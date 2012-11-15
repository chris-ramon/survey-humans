class AddColumnCourseToMatches < ActiveRecord::Migration
  def self.up
  	add_column :matches, :course_id, :integer, :null=>true
  end

  def self.down
  	remove_column :matches, :course_id
  end
end
