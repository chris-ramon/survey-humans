class CreatePanelBillings < ActiveRecord::Migration
  def self.up
    create_table :panel_billings do |t|
      t.references :user
      t.references :country
      t.string :street_address
      t.string :zip_code
      t.string :cardholder_first_name
      t.string :cardholder_last_name
      t.integer :number
      t.integer :cvv
      t.datetime :exp_date
      t.string :billing_email

      t.timestamps
    end
  end

  def self.down
    drop_table :panel_billings
  end
end
