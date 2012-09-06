begin
	
	Access.create_migration({:id=>33,:name=>"question_level", :parent_id=>22, :controller=>'match_management/question_level', :action=>'index',:panel=>0}) #33
	  Access.create_migration({:id=>34,:name=>"new", :parent_id=>33}) #34
	  Access.create_migration({:id=>35,:name=>"show", :parent_id=>33}) #35
	  Access.create_migration({:id=>36,:name=>"edit", :parent_id=>33}) #36
	  Access.create_migration({:id=>37,:name=>"delete", :parent_id=>33}) #37

	Profile.all.each do |profile|
		33.upto 37 do |access_id|
			if profile.id==1
				profile.access_profiles.build({:access_id=>access_id})
			else
				profile.access_profiles.build({:access_id=>access_id, :deleted=>1})
			end
		end
		profile.save
	end

end