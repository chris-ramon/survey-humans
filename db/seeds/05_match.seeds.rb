begin
	
	Access.create_migration({:id=>22,:name=>"match", :parent_id=>0, :controller=>'match_management/match', :action=>'match_panel',:panel=>0}) #22

	Access.create_migration({:id=>23,:name=>"match", :parent_id=>22, :controller=>'match_management/match', :action=>'index',:panel=>0}) #23
	  Access.create_migration({:id=>24,:name=>"new", :parent_id=>23}) #24
	  Access.create_migration({:id=>25,:name=>"show", :parent_id=>23}) #25
	  Access.create_migration({:id=>26,:name=>"edit", :parent_id=>23}) #26
	  Access.create_migration({:id=>27,:name=>"delete", :parent_id=>23}) #27

	Profile.all.each do |profile|
		22.upto 27 do |access_id|
			if profile.id==1
				profile.access_profiles.build({:access_id=>access_id})
			else
				profile.access_profiles.build({:access_id=>access_id, :deleted=>1})
			end
		end
		profile.save
	end

end