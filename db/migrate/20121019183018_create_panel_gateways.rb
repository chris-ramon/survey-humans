class CreatePanelGateways < ActiveRecord::Migration
  def self.up
    create_table :panel_gateways do |t|
      t.string :name
      t.string :website
      t.boolean :status
      t.string :login
      t.string :password, :limit => 125

      t.timestamps
    end
  end

  def self.down
    drop_table :panel_gateways
  end
end
