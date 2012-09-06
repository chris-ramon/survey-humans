class CreateQuestionTypeExamTopics < ActiveRecord::Migration
  def self.up
    create_table :question_type_exam_topics do |t|
      t.integer :question_type_id, :null => false
      t.integer :exam_topic_id, :null => false
      t.integer :deleted, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :question_type_exam_topics
  end
end
