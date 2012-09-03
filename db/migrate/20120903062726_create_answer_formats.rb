class CreateAnswerFormats < ActiveRecord::Migration
  def self.up
    create_table :answer_formats do |t|
      t.string :name, :null => false
      t.string :format, :null => false
      t.integer :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :answer_formats
  end
end
