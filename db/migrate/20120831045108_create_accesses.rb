class CreateAccesses < ActiveRecord::Migration
  def self.up
    create_table :accesses do |t|
      t.string :name, :null => false
      t.integer :parent_id, :null => false
      t.string :controller
      t.string :action
      t.integer :panel, :null => false, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :accesses
  end
end
