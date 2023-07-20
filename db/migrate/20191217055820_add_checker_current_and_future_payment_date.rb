class AddCheckerCurrentAndFuturePaymentDate < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :checker_paid_date, :date
    add_column :users, :checker_future_payment, :date
  end
end
