class AddColumnDeletedToCourse < ActiveRecord::Migration
  def self.up
  	add_column :courses, :deleted, :integer, :default=>0
  end

  def self.down
  	remove_column :courses, :deleted
  end
end
