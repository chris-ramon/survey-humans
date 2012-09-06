class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :deleted, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
