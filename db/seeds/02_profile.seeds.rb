admin_profile = Profile.create({:name=>"Administrator Application"})
user_profile = Profile.create({:name=>"User Application"})
Access.all.each do |access|
  admin_profile.access_profiles.build({:access_id=>access.id})
  user_profile.access_profiles.build({:access_id=>access.id}) unless access.id==3 or (6<=access.id and access.id<=16) or (30<=access.id and access.id<=32)
end
admin_profile.save
user_profile.save
