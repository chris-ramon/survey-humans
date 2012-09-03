class CreateAccountManagementUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :null => false
      t.string :encrypted_password, :null => false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :last_sign_in_at
      t.string :name, :null => false
      t.string :lastname, :null => false
      t.integer :deleted, :default => 0
      t.integer :profile_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
