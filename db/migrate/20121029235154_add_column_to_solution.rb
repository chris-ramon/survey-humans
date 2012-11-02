class AddColumnToSolution < ActiveRecord::Migration
  def self.up
  	add_column :solutions, :match_id, :integer, :null=>false
  	add_column :solutions, :image_file_name, :string
    add_column :solutions, :image_content_type, :string
    add_column :solutions, :image_file_size, :integer
    add_column :solutions, :image_updated_at, :datetime
  end

  def self.down
  	remove_column :solutions, :match_id
  	add_column :solutions, :image_file_name
    add_column :solutions, :image_content_type
    add_column :solutions, :image_file_size
    add_column :solutions, :image_updated_at
  end
end
