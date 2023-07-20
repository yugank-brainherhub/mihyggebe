class CreateProviderSupports < ActiveRecord::Migration[5.2]
  def change
    create_table :provider_supports do |t|
      t.string :name
      t.string :contact_type
      t.boolean :active
      t.integer :user_id
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
