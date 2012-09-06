class CreateAccesses < ActiveRecord::Migration
  def self.up
    create_table :accesses do |t|
      t.string :name, :null => false
      t.integer :parent_id, :references => nil, :null=>false
      t.string :controller, :null=>true
      t.string :action, :null=>true
      t.integer :panel, :null => false, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :accesses
  end
end
