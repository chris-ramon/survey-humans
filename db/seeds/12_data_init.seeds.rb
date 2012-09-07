Company.create({:name=>"Company 01",
				:user_id=>1,
				:deleted=>0})

MatchType.create({:name=>"Survey"})
MatchType.create({:name=>"Exam"})

QuestionLevel.create({:range=>"Easy",:deleted=>0})
QuestionLevel.create({:range=>"Medium",:deleted=>0})
QuestionLevel.create({:range=>"Hard",:deleted=>0})
QuestionLevel.create({:range=>"Genius",:deleted=>0})

Match.create({:name=>"Match 01",
			:url=>"http://localhost:3000/matches/survey/administrator/1",
			:started=>1,
			:match_type_id=>2,
			:question_level_id=>2,
			:deleted=>0,
			:user_id=>1})


AnswerFormat.create({:name=>"Multiple Choice",
					:format=>"abc",
					:deleted=>0})

QuestionType.create({:name=>"Math",
	:description=>"Mathematic Question",
	:deleted=>0
	})
QuestionType.create({:name=>"History",
	:description=>"History Question",
	:deleted=>0
	})

Question.create({:question=>"It's 8 o'clock. What time is it? 2h+5min+10h",
				:correct_answer=>"20h 5min",
				:answer_format_id=>1,
				:question_type_id=>1,
				:match_id=>1,
				:deleted=>0
	})

Answer.create({:answer=>"3h 0min",
	:is_correct=>0,
	:percent=>nil,
	:question_id=>1
	})
Answer.create({:answer=>"4h 1min",
	:is_correct=>0,
	:percent=>nil,
	:question_id=>1
	})
Answer.create({:answer=>"12h 3min",
	:is_correct=>0,
	:percent=>nil,
	:question_id=>1
	})
Answer.create({:answer=>"22h 12min",
	:is_correct=>0,
	:percent=>nil,
	:question_id=>1
	})
Answer.create({:answer=>"20h 9min",
	:is_correct=>0,
	:percent=>nil,
	:question_id=>1
	})
Answer.create({:answer=>"20h 5min",
	:is_correct=>1,
	:percent=>nil,
	:question_id=>1
	})
Answer.create({:answer=>"3h 10min",
	:is_correct=>0,
	:percent=>nil,
	:question_id=>1
	})
Answer.create({:answer=>"4h 12min",
	:is_correct=>0,
	:percent=>nil,
	:question_id=>1
	})
Answer.create({:answer=>"20h 10min",
	:is_correct=>0,
	:percent=>nil,
	:question_id=>1
	})
Answer.create({:answer=>"3h 12min",
	:is_correct=>0,
	:percent=>nil,
	:question_id=>1
	})
Answer.create({:answer=>"7h 10min",
	:is_correct=>0,
	:percent=>nil,
	:question_id=>1
	})
Answer.create({:answer=>"10h 20min",
	:is_correct=>0,
	:percent=>nil,
	:question_id=>1
	})
