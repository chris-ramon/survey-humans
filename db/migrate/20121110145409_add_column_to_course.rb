class AddColumnToCourse < ActiveRecord::Migration
  def self.up
  	add_column :courses, :user_id, :integer, :null=>false
  end

  def self.down
  	remove_column :courses, :user_id
  end
end
