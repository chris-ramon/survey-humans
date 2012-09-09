class ChangeColumnNotNullToNullOnUsers < ActiveRecord::Migration
  def self.up
  	change_column :users, :name, :string, :null=>true
  	change_column :users, :lastname, :string, :null=>true
  end

  def self.down
  	change_column :users, :name, :string, :null=>false
  	change_column :users, :lastname, :string, :null=>false
  end
end
