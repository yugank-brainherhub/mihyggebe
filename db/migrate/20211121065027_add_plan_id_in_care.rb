class AddPlanIdInCare < ActiveRecord::Migration[5.2]
  def change
    add_column :cares, :plan_id, :integer
  end
end
