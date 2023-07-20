class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.float :provider_amount
      t.float :mih_commission_amt
      t.string :transferId, unique: true, index: true
      t.integer :status
      t.references(:booking, index: true)
      t.references(:payment, index: true)
      t.timestamps
    end
  end
end
