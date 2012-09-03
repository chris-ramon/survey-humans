class CreateQuestionLevels < ActiveRecord::Migration
  def self.up
    create_table :question_levels do |t|
      t.string :range, :null => false
      t.integer :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :question_levels
  end
end
