begin

	Access.create_migration({:id=>17,:name=>"company", :parent_id=>1, :controller=>'account_management/company', :action=>'index',:panel=>0}) #17
	  Access.create_migration({:id=>18,:name=>"new", :parent_id=>17}) #18
	  Access.create_migration({:id=>19,:name=>"show", :parent_id=>17}) #19
	  Access.create_migration({:id=>20,:name=>"edit", :parent_id=>17}) #20
	  Access.create_migration({:id=>21,:name=>"delete", :parent_id=>17}) #21

	Profile.all.each do |profile|
		17.upto 21 do |access_id|
			if profile.id==1
				profile.access_profiles.build({:access_id=>access_id})
			else
				profile.access_profiles.build({:access_id=>access_id, :deleted=>1})
			end
		end
		profile.save
	end

end