class CreateMatchaccessMatches < ActiveRecord::Migration
  def self.up
    create_table :matchaccess_matches do |t|
      t.integer :match_access_id, :null => false
      t.integer :match_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :matchaccess_matches
  end
end
