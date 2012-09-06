begin
	
	Access.create_migration({:id=>48,:name=>"answer", :parent_id=>22, :controller=>'match_management/answer', :action=>'index',:panel=>0}) #48
	  Access.create_migration({:id=>49,:name=>"new", :parent_id=>48}) #49
	  Access.create_migration({:id=>50,:name=>"show", :parent_id=>48}) #50
	  Access.create_migration({:id=>51,:name=>"edit", :parent_id=>48}) #51
	  Access.create_migration({:id=>52,:name=>"delete", :parent_id=>48}) #52

	Profile.all.each do |profile|
		48.upto 52 do |access_id|
			if profile.id==1
				profile.access_profiles.build({:access_id=>access_id})
			else
				profile.access_profiles.build({:access_id=>access_id, :deleted=>1})
			end
		end
		profile.save
	end

end