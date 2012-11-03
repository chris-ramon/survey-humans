class CreatePanelOrganizations < ActiveRecord::Migration
  def self.up
    create_table :panel_organizations do |t|
      t.references :User
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :panel_organizations
  end
end
