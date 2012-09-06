class AddInfoToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string, :null=>false
    add_column :users, :lastname, :string, :null=>false
    add_column :users, :deleted, :integer, :default=>0
  end

  def self.down
  	remove_column :users, :name, :string, :null=>false
    remove_column :users, :lastname, :string, :null=>false
    remove_column :users, :deleted, :integer, :default=>0
  end
end
