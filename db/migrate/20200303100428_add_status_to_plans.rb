class AddStatusToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :status, :integer, default: 0
  end
end
