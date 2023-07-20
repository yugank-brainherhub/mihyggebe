class CreateWishlists < ActiveRecord::Migration[5.2]
  def change
    create_table :wishlists do |t|
      t.references(:care, index: true)
      t.references(:user, index: true)
      t.timestamps
    end
  end
end
