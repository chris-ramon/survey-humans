class AddColumnStudentToSolution < ActiveRecord::Migration
  def self.up
  	add_column :solutions, :student_id, :integer, :null=>true
  end

  def self.down
  	remove_column :solutions, :student_id
  end
end
