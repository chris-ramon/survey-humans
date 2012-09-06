class CreateMatchTypes < ActiveRecord::Migration
  def self.up
    create_table :match_types do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :deleted, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :match_types
  end
end
