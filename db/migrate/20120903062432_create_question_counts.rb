class CreateQuestionCounts < ActiveRecord::Migration
  def self.up
    create_table :question_counts do |t|
      t.integer :value, :null => false
      t.integer :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :question_counts
  end
end
