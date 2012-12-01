class AddColumnStatusSubscription < ActiveRecord::Migration
  def self.up
    add_column :panel_subscriptions, :status, :boolean, :null => true
  end

  def self.down
    remove_column :panel_subscriptions, :status
  end
end
