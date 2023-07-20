class CreateCares < ActiveRecord::Migration[5.2]
  def change
    create_table :cares do |t|
      t.text :address1
      t.text :address2
      t.text :address3
      t.string :county
      t.string :country
      t.string :zipcode
      t.string :state
      t.string :fax_number
      t.integer :category
      t.integer :status
      t.text :board_members
      t.timestamps
    end
  end
end
