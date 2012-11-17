Access.create_migration({:id=>58,:name=>"organization", :parent_id=>0, :controller=>'organization_management/company', :action=>'organization_panel',:panel=>0}) #58
	Profile.all.each do |profile|
		if profile.id==1
			profile.access_profiles.build({:access_id=>58})
		else
			profile.access_profiles.build({:access_id=>58, :deleted=>1})
		end
		profile.save
	end
access_company = Access.find(17)
access_company.name="organization"
access_company.parent_id=58
access_company.controller="organization_management/company"
access_company.save

MatchType.create({:id=>1,:name=>"Survey"})
MatchType.create({:id=>2,:name=>"Exam"})

QuestionLevel.create({:id=>1,:range=>"Easy",:deleted=>0})
QuestionLevel.create({:id=>2,:range=>"Medium",:deleted=>0})
QuestionLevel.create({:id=>3,:range=>"Hard",:deleted=>0})
QuestionLevel.create({:id=>4,:range=>"Genius",:deleted=>0})

AnswerFormat.create({:id=>1,:name=>"Multiple Choices - 1 answer",
					:format=>"id",
					:deleted=>0})
AnswerFormat.create({:id=>2,:name=>"Multiple Choices - Multiple answers",
					:format=>"id@id@id",
					:deleted=>0})
AnswerFormat.create({:id=>3,:name=>"Comment / Essay Box",
					:format=>"value",
					:deleted=>0})
AnswerFormat.create({:id=>4,:name=>"Ranking",
					:format=>"value",
					:deleted=>0})
AnswerFormat.create({:id=>5,:name=>"Matrix (One answer per row)",
					:format=>"id@id@id",
					:deleted=>0})
AnswerFormat.create({:id=>6,:name=>"Matrix (Multiple answers per row)",
					:format=>"id@id@id",
					:deleted=>0})
AnswerFormat.create({:id=>7,:name=>"Datetime / hour",
					:format=>"value",
					:deleted=>0})
AnswerFormat.create({:id=>8,:name=>"File picker",
					:format=>"image",
					:deleted=>0})

QuestionType.create({:id=>1,:name=>"Math",
	:description=>"Mathematic Question",
	:deleted=>0
	})
QuestionType.create({:id=>2,:name=>"History",
	:description=>"History Question",
	:deleted=>0
	})