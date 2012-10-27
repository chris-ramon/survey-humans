class CreatePanelPlanfeatures < ActiveRecord::Migration
  def self.up
    create_table :panel_planfeatures do |t|
      t.references :panel_plan
      t.references :panel_feature
      t.integer :up_to

      t.timestamps
    end
  end

  def self.down
    drop_table :panel_planfeatures
  end
end
