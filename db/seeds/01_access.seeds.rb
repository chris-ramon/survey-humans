#encoding: utf-8
Access.create_migration({:id=>1,:name=>"account", :parent_id=>0, :controller=>'account_management/user', :action=>'account_panel',:panel=>0}) #1

Access.create_migration({:id=>2,:name=>"user", :parent_id=>1, :controller=>'account_management/user', :action=>'index',:panel=>0}) #2
  Access.create_migration({:id=>3,:name=>"new", :parent_id=>2}) #3
  Access.create_migration({:id=>4,:name=>"show", :parent_id=>2}) #4
  Access.create_migration({:id=>5,:name=>"edit", :parent_id=>2}) #5
  Access.create_migration({:id=>6,:name=>"delete", :parent_id=>2}) #6

Access.create_migration({:id=>7,:name=>"profile", :parent_id=>1, :controller=>'account_management/profile', :action=>'index',:panel=>0}) #7
  Access.create_migration({:id=>8,:name=>"new", :parent_id=>7}) #8
  Access.create_migration({:id=>9,:name=>"show", :parent_id=>7}) #9
  Access.create_migration({:id=>10,:name=>"edit", :parent_id=>7}) #10
  Access.create_migration({:id=>11,:name=>"delete", :parent_id=>7}) #11

Access.create_migration({:id=>12,:name=>"log", :parent_id=>1, :controller=>'account_management/log', :action=>'index',:panel=>0}) #12
  Access.create_migration({:id=>13,:name=>"new", :parent_id=>12}) #13
  Access.create_migration({:id=>14,:name=>"show", :parent_id=>12}) #14
  Access.create_migration({:id=>15,:name=>"edit", :parent_id=>12}) #15
  Access.create_migration({:id=>16,:name=>"delete", :parent_id=>12}) #16