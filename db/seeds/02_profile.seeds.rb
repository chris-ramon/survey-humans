admin_profile = Profile.create({:name=>"Administrator Application"})
Access.all.each do |access|
  admin_profile.access_profiles.build({:access_id=>access.id})
end
admin_profile.save
