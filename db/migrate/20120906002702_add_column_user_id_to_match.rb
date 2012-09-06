class AddColumnUserIdToMatch < ActiveRecord::Migration
  def self.up
  	add_column :matches, :user_id, :integer, :null=>false
  end

  def self.down
  	remove_column :matches, :user_id
  end
end
