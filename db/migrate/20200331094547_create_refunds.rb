class CreateRefunds < ActiveRecord::Migration[5.2]
  def change
    create_table :refunds do |t|
      t.float :amount
      t.string :chargeId, unique: true
      t.string :refundId, unique: true, index: true
      t.text :description
      t.integer :status
      t.references(:booking, index: true)
      t.references(:payment, index: true)
      t.timestamps  
    end
  end
end
