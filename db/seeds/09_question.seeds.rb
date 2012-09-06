begin
	
	Access.create_migration({:id=>43,:name=>"question", :parent_id=>22, :controller=>'match_management/question', :action=>'index',:panel=>0}) #43
	  Access.create_migration({:id=>44,:name=>"new", :parent_id=>43}) #44
	  Access.create_migration({:id=>45,:name=>"show", :parent_id=>43}) #45
	  Access.create_migration({:id=>46,:name=>"edit", :parent_id=>43}) #46
	  Access.create_migration({:id=>47,:name=>"delete", :parent_id=>43}) #47

	Profile.all.each do |profile|
		43.upto 47 do |access_id|
			if profile.id==1
				profile.access_profiles.build({:access_id=>access_id})
			else
				profile.access_profiles.build({:access_id=>access_id, :deleted=>1})
			end
		end
		profile.save
	end

end