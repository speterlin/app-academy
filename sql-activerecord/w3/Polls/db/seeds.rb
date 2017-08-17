# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user1 = User.create!(user_name: 'kevin')
user2 = User.create!(user_name: 'sebastian')
user3 = User.create!(user_name: 'david')

poll1 = Poll.create!(title: 'math', author_id: 1)
poll2 = Poll.create!(title: 'science', author_id: 2)

# poll1.questions.create!(text: "automagic")

question1 = Question.create!(text: "poll 1: what is an integer?", poll_id: 1)
question2 = Question.create!(text: "poll 1: what is a float?", poll_id: 1)
question3 = Question.create!(text: "poll 2: favorite science?", poll_id: 2)

answerchoice1 = AnswerChoice.create!(text: "whole number", question_id: 1)
answerchoice2 = AnswerChoice.create!(text: "non-whole number", question_id: 1)
answerchoice3 = AnswerChoice.create!(text: "computer science", question_id: 2)
answerchoice4 = AnswerChoice.create!(text: "biology", question_id: 3)

response1 = Response.create!(user_id: 1, answer_choice_id: 1)
response2 = Response.create!(user_id: 1, answer_choice_id: 2)
response3 = Response.create!(user_id: 2, answer_choice_id: 1)
response4 = Response.create!(user_id: 2, answer_choice_id: 2)
response5 = Response.create!(user_id: 3, answer_choice_id: 3)
response6 = Response.create!(user_id: 3, answer_choice_id: 4)
# response7 = Response.create!(user_id: 2, answer_choice_id: 4)
