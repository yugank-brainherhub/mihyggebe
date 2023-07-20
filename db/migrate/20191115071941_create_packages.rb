class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.references :subscription, foreign_key: true
      t.references :plan, foreign_key: true
      t.timestamps
    end
  end
end
