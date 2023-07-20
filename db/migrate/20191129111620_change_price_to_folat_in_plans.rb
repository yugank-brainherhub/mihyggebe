class ChangePriceToFolatInPlans < ActiveRecord::Migration[5.2]
  def change
    change_column :plans, :price, :float, default: 0.0
  end
end
