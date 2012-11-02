class CreateSolutions < ActiveRecord::Migration
  def self.up
    create_table :solutions do |t|
      t.integer :question_id
      t.string :answer

      t.timestamps
    end
  end

  def self.down
    drop_table :solutions
  end
end
