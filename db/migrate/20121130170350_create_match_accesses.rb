class CreateMatchAccesses < ActiveRecord::Migration
  def self.up
    create_table :match_accesses do |t|
      t.integer :panel_organization_member_id
      t.timestamps
    end
  end

  def self.down
    drop_table :match_accesses
  end
end
