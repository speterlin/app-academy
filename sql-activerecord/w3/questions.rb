require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database

  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end

end

class User

  # attr_accessor :id, :fname, :lname

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    raw_data = QuestionsDatabase.instance.execute('SELECT * FROM users WHERE id = ?', id)
    User.new(raw_data[0])
  end

  def self.find_by_name(fname,lname)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL,fname,lname)
    SELECT * FROM users WHERE fname = ? AND lname = ?
    SQL
    User.new(raw_data[0])
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionFollow.liked_questions_for_user_id(@id)
  end

  def average_karma
    raw_data = QuestionsDatabase.instance.execute(<<-SQL,@id)
    SELECT
      COUNT(DISTINCT())
    FROM
      question_likes
    LEFT OUTER JOIN
      questions on questions.id = question_likes.question_id


    # questions = Question.find_by_author_id(@id)
    # likes = 0
    # questions.each {|question| likes += question.num_likes }
    # questions.size / likes.to_f
  end

end

class Question
  def self.find_by_author_id(author_id)
    raw_data = QuestionsDatabase.instance.execute('SELECT * FROM questions WHERE author_id = ?', author_id)
    raw_data.map { |row| Question.new(row) }
  end

  attr_accessor :id, :title, :body, :author_id

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def self.find_by_id(id)
    raw_data = QuestionsDatabase.instance.execute('SELECT * FROM questions WHERE id = ?', id)
    Question.new(raw_data[0])
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def author
    # raw_data = QuestionsDatabase.instance.execute('SELECT * FROM questions WHERE author_id = ?', @author_id)
    User.find_by_id(author_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionFollow.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def most_liked(n)
    QuestionFollow.most_liked_questions(n)
  end

end

class Reply

  def self.find_by_user_id(author_id)
    raw_data = QuestionsDatabase.instance.execute('SELECT * FROM replies WHERE author_id = ?', author_id)
    raw_data.map { |row| Reply.new(row) }
  end

  def self.find_by_question_id(question_id)
    raw_data = QuestionsDatabase.instance.execute('SELECT * FROM replies WHERE question_id = ?', question_id)
    raw_data.map { |row| Reply.new(row) }
  end

  def self.find_by_id(id)
    raw_data = QuestionsDatabase.instance.execute('SELECT * FROM replies WHERE id = ?', id)
    Reply.new(raw_data[0])
  end

  attr_accessor :id, :body, :author_id, :parent_id, :question_id

  def initialize(options = {})
    @id = options['id']
    @body = options['body']
    @author_id = options['author_id']
    @parent_id = options['parent_id']
    @question_id = options['question_id']
  end


  def author
    User.find_by_id(@author_id)
  end

  def child_replies
    QuestionsDatabase.instance.execute('SELECT * FROM replies WHERE parent_id = ?', @id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    if @parent_id.nil?
      return 'no parent'
    end
    Reply.find_by_id(@parent_id)
  end

end

class QuestionFollow

  def self.most_followed_questions(n)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL,n)
        SELECT
          questions.id, questions.title, questions.body, questions.author_id
        FROM
          question_follow
        JOIN
          questions on questions.id = question_follow.question_id
        JOIN
          users on users.id = question_follow.user_id
        -- WHERE
        --   questions.id IN (SELECT
        --                      question_id
        --                    FROM
        --                      question_follow
        --                    GROUP BY
        --                      question_id
        --                    ORDER BY
        --                      COUNT(user_id) DESC
        --                     LIMIT
        --                       ?
        --                     )
        GROUP BY
          question_id
        ORDER BY
          count(user_id) DESC
        LIMIT
          ?
        SQL
        raw_data.map { |row| Question.new(row) }

  end

  def self.followers_for_question_id(question_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL,question_id)
    SELECT
      users.id, users.fname, users.lname
    FROM
      question_follow
    JOIN
      questions on questions.id = question_follow.question_id
    JOIN
      users on users.id = question_follow.user_id
    WHERE
      question_id = ?
    SQL
    raw_data.map{|row| User.new(row) }
  end

  def self.followed_questions_for_user_id(user_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL,user_id)
    SELECT
      questions.id, questions.title, questions.body, questions.author_id
    FROM
      question_follow
    JOIN
      questions on questions.id = question_follow.question_id
    JOIN
      users on users.id = question_follow.user_id
    WHERE
      user_id = ?
    SQL
    raw_data.map{|row| Question.new(row) }
  end

end


class QuestionLike
  def self.likers_for_question_id(question_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL,question_id)
    SELECT
      users.id, users.fname, users.lname
    FROM
      question_likes
    JOIN
      questions on questions.id = question_likes.question_id
    JOIN
      users on users.id = question_likes.user_id
    WHERE
      question_id = ?
    SQL
    raw_data.map{|row| User.new(row) }
  end

  def self.num_likes_for_question_id(question_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL,question_id)
    SELECT
      COUNT(*)
    FROM
      question_likes
    JOIN
      questions on questions.id = question_likes.question_id
    JOIN
      users on users.id = question_likes.user_id
    WHERE
      question_id = ?
    GROUP BY
      question_id
    SQL
    return raw_data[0][0] unless raw_data.empty?
    0
  end

  def self.liked_questions_for_user_id(user_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL,user_id)
    SELECT
      questions.id, questions.title, questions.body, questions.author_id
    FROM
      question_likes
    JOIN
      questions on questions.id = question_likes.question_id
    JOIN
      users on users.id = question_likes.user_id
    WHERE
      user_id = ?
    SQL
    raw_data.map{|row| Question.new(row) }
  end

  def self.most_liked_questions(n)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL,n)
    SELECT
      questions.id,questions.title,questions.body,questions.author_id
    FROM
      question_likes
    JOIN
      questions on questions.id = question_likes.question_id
    JOIN
      users on users.id = question_likes.user_id
    GROUP BY
      questions.id
    ORDER BY
      count(user_id) DESC
    LIMIT
      ?
    SQL
    raw_data.map{|row| Question.new(row) }
  end

end

# p QuestionLike.num_likes_for_question_id(3)
bob = User.find_by_id(2)
p bob.average_karma
