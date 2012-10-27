class ChangeColumnIsCorrectOnAnswer < ActiveRecord::Migration
  def self.up
  	change_column :answers, :is_correct, :string, :null=>true
  end

  def self.down
  	change_column :answers, :is_correct, :string, :null=>false
  end
end
