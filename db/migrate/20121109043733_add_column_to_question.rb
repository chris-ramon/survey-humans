class AddColumnToQuestion < ActiveRecord::Migration
  def self.up
  	add_column :questions, :obligatory, :integer, :null=>false, :default=>1
  end

  def self.down
  	remove_column :questions, :obligatory,
  end
end
