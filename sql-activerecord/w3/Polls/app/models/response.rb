class Response < ActiveRecord::Base
  validate :respondent_has_not_already_answered_question
  validate :respondent_cant_be_author

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses
    return self.question.responses unless self.id
    return self.question.responses.where.not(id: self.id) if self.id
  end

  def results
  

  end

  private
  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: self.respondent.id)
      errors[:user_id] << "Already responded to this question"
    end
  end

  def respondent_cant_be_author
    author = self.answer_choice.question.poll.author
    if author.id == self.respondent.id
      errors[:user_id] << "Respondent can't be author"
    end
  end



end
