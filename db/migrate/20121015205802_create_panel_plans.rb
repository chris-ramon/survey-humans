class CreatePanelPlans < ActiveRecord::Migration
  def self.up
    create_table :panel_plans do |t|
      t.string :name
      t.decimal :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :panel_plans
  end
end
