class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.float :amount
      t.string :chargeId, unique: true, index: true
      t.text :description
      t.integer :status
      t.references(:booking, index: true)
      t.timestamps
    end
  end
end
