class CreateAccessProfiles < ActiveRecord::Migration
  def self.up
    create_table :access_profiles do |t|
      t.integer :access_id, :null => false
      t.integer :profile_id, :null => false
      t.integer :deleted, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :access_profiles
  end
end
