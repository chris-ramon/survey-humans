class AddProfileToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :profile_id, :integer, :null=>false
  end

  def self.down
  end
end
