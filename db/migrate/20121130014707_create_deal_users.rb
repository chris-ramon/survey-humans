class CreateDealUsers < ActiveRecord::Migration
  def self.up
    create_table :deal_users do |t|
      t.integer :panel_deal_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :deal_users
  end
end
