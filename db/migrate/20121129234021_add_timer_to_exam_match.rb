class AddTimerToExamMatch < ActiveRecord::Migration
  def self.up
  	add_column :matches, :start_time, :datetime, :null=>true
  	add_column :matches, :end_time, :datetime, :null=>true
  end

  def self.down
  	remove_column :matches, :start_time
  	remove_column :matches, :end_time
  end
end
