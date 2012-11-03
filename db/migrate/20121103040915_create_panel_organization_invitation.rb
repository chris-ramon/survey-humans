class CreatePanelOrganizationInvitation < ActiveRecord::Migration
  def self.up
    create_table :panel_organization_invitations do |t|
      t.references :User
      t.references :panel_organization
      t.integer :status
      t.timestamps
    end
  end

  def self.down
    drop_table :panel_organization_invitations
  end
end
