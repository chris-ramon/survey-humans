class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.text :question, :null => false
      t.string :correct_answer
      t.integer :answer_format_id, :null => false
      t.integer :question_type_id
      t.integer :match_id, :null => false
      t.integer :deleted, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
