class CreatePanelSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :panel_subscriptions do |t|
      t.references :User
      t.references :panel_plan
      t.references :panel_deal, :null => true
      t.datetime :expired_at

      t.timestamps
    end
  end

  def self.down
    drop_table :panel_subscriptions
  end
end
