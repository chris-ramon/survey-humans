class CreateExamTopics < ActiveRecord::Migration
  def self.up
    create_table :exam_topics do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :deleted, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :exam_topics
  end
end
