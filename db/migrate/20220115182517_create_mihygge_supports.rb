class CreateMihyggeSupports < ActiveRecord::Migration[5.2]
  def change
    create_table :mihygge_supports do |t|
      t.string :support_type
      t.text :description
      t.string :file_1
      t.integer :user_id
      t.string :email
      t.string :phone_number
      t.string :first_name
      t.string :last_name
      t.string :support_number
      t.boolean :is_provider
      t.integer :provider_id
      t.string :subject
      t.string :category
      t.string :booking
      t.string :referance

      t.timestamps
    end
  end
end
