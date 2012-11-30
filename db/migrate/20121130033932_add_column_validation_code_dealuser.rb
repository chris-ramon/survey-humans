class AddColumnValidationCodeDealuser < ActiveRecord::Migration
  def self.up
    add_column :deal_users, :validation_code, :string, :null => false
  end

  def self.down
    remove_column :deal_users, :validation_code
  end
end
