class CreatePanelOrganizationMember < ActiveRecord::Migration
  def self.up
    create_table :panel_organization_members do |t|
      t.references :User
      t.references :panel_organization
      t.timestamps
    end
  end

  def self.down
    drop_table :panel_organization_members
  end
end
