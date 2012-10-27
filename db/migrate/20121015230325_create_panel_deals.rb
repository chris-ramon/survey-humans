class CreatePanelDeals < ActiveRecord::Migration
  def self.up
    create_table :panel_deals do |t|
      t.references :panel_plan
      t.datetime :valid_until
      t.integer :deal_type
      t.integer :deal

      t.timestamps
    end
  end

  def self.down
    drop_table :panel_deals
  end
end
