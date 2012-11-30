class AddColumnStatusDealuser < ActiveRecord::Migration
  def self.up
    add_column :deal_users, :status, :boolean, :null => false
  end

  def self.down
    remove_column :deal_users, :status
  end
end
