class AddColumnToAnswerFormat < ActiveRecord::Migration
  def self.up
  	add_column :answer_formats, :enable_to_exams, :integer, :null=>true, :default=>1
  end

  def self.down
  	remove_column :answer_formats, :enable_to_exams
  end
end
