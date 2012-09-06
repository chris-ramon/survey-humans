begin
	
	Access.create_migration({:id=>53,:name=>"answer_format", :parent_id=>22, :controller=>'match_management/answer_format', :action=>'index',:panel=>0}) #53
	  Access.create_migration({:id=>54,:name=>"new", :parent_id=>53}) #54
	  Access.create_migration({:id=>55,:name=>"show", :parent_id=>53}) #55
	  Access.create_migration({:id=>56,:name=>"edit", :parent_id=>53}) #56
	  Access.create_migration({:id=>57,:name=>"delete", :parent_id=>53}) #57

	Profile.all.each do |profile|
		53.upto 57 do |access_id|
			if profile.id==1
				profile.access_profiles.build({:access_id=>access_id})
			else
				profile.access_profiles.build({:access_id=>access_id, :deleted=>1})
			end
		end
		profile.save
	end

end