class AddColumnToMatch < ActiveRecord::Migration
  def self.up
  	add_column :matches, :pdf_url, :string, :null=>true
  end

  def self.down
  	remove_column :matches, :pdf_url
  end
end
