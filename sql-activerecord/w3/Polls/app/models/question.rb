class Question < ActiveRecord::Base

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )
  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    # res = {}
    # self.answer_choices.each do |answer_choice|
    #   res[answer_choice.text] = answer_choice.responses.count
    # end
    # res
    # results = {}
    # self.answer_choices.includes(:responses).each do |ac|
    #   results[ac.text] = ac.responses.length
    # end
    # results
    acs = self.answer_choices
    .select("answer_choices.*, COUNT(responses.id) AS num_responses")
      .joins(<<-SQL).group("answer_choices.id")
LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id
    SQL

    acs.inject({}) do |results, ac|
      results[ac.text] = ac.num_responses; results
    end

  end


end
