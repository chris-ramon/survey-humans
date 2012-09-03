class CreateCompanyUsers < ActiveRecord::Migration
  def self.up
    create_table :company_users do |t|
      t.integer :company_id, :null => false
      t.integer :user_id, :null => false
      t.integer :deleted, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :company_users
  end
end
