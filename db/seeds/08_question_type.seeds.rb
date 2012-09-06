begin
	
	Access.create_migration({:id=>38,:name=>"question_type", :parent_id=>22, :controller=>'match_management/question_type', :action=>'index',:panel=>0}) #38
	  Access.create_migration({:id=>39,:name=>"new", :parent_id=>38}) #39
	  Access.create_migration({:id=>40,:name=>"show", :parent_id=>38}) #40
	  Access.create_migration({:id=>41,:name=>"edit", :parent_id=>38}) #41
	  Access.create_migration({:id=>42,:name=>"delete", :parent_id=>38}) #42

	Profile.all.each do |profile|
		38.upto 42 do |access_id|
			if profile.id==1
				profile.access_profiles.build({:access_id=>access_id})
			else
				profile.access_profiles.build({:access_id=>access_id, :deleted=>1})
			end
		end
		profile.save
	end

end