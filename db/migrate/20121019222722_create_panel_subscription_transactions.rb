class CreatePanelSubscriptionTransactions < ActiveRecord::Migration
  def self.up
    create_table :panel_subscription_transactions do |t|
      t.references :panel_subscription
      t.references :panel_gateway
      t.decimal :amount
      t.boolean :success
      t.integer :reference
      t.string :message
      t.string :action
      t.string :params
      t.boolean :test

      t.timestamps
    end
  end

  def self.down
    drop_table :panel_subscription_transactions
  end
end
