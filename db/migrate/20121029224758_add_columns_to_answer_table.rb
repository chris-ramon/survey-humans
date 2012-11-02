class AddColumnsToAnswerTable < ActiveRecord::Migration
  def self.up
  	add_column :answers, :position, :string, :null=>true
  end

  def self.down
  	remove_column :answers, :position, :string, :null=>true
  end
end
