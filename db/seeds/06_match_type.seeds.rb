begin
	
	Access.create_migration({:id=>28,:name=>"match_type", :parent_id=>22, :controller=>'match_management/match_type', :action=>'index',:panel=>0}) #28
	  Access.create_migration({:id=>29,:name=>"new", :parent_id=>28}) #29
	  Access.create_migration({:id=>30,:name=>"show", :parent_id=>28}) #30
	  Access.create_migration({:id=>31,:name=>"edit", :parent_id=>28}) #31
	  Access.create_migration({:id=>32,:name=>"delete", :parent_id=>28}) #32

	Profile.all.each do |profile|
		28.upto 32 do |access_id|
			if profile.id==1
				profile.access_profiles.build({:access_id=>access_id})
			else
				profile.access_profiles.build({:access_id=>access_id, :deleted=>1})
			end
		end
		profile.save
	end

end