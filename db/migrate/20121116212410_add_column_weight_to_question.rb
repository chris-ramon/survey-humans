class AddColumnWeightToQuestion < ActiveRecord::Migration
  def self.up
  	add_column :questions, :weight, :float, :null=>true
  end

  def self.down
  	remove_column :questions, :weight
  end
end
