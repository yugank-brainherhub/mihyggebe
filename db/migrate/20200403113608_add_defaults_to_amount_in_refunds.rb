class AddDefaultsToAmountInRefunds < ActiveRecord::Migration[5.2]
  def change
    change_column_default :refunds, :amount, 0.0
  end
end
