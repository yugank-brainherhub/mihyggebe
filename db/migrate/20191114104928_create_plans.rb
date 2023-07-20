class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.integer :min
      t.integer :max
      t.string :planId
      t.timestamps
    end
  end
end
