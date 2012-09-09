class AddProfileToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :profile_id, :integer, :null=>false, :default => 2
  end

  def self.down
  end
end
