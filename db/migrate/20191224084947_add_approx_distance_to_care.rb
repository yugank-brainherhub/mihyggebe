class AddApproxDistanceToCare < ActiveRecord::Migration[5.2]
  def change
    add_column :cares, :approx_distance, :float, default: 0.0
  end
end
