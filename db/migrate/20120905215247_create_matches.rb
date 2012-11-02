class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.string :name, :null => false
      t.string :url
      t.integer :started, :default => 0
      t.integer :match_type_id, :null => false
      t.integer :question_level_id
      t.integer :deleted, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
