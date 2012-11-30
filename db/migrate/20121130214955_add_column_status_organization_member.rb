class AddColumnStatusOrganizationMember < ActiveRecord::Migration
  def self.up
    add_column :panel_organization_members, :status, :boolean, :null => false
  end

  def self.down
    remove_column :panel_organization_members, :status
  end
end
