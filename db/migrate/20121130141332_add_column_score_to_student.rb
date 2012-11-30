class AddColumnScoreToStudent < ActiveRecord::Migration
  def self.up
  	add_column :students, :corrects, :float, :null=>true
  	add_column :students, :score, :float, :null=>true
  end

  def self.down
  	remove_column :students, :corrects
  	remove_column :students, :score
  end
end
