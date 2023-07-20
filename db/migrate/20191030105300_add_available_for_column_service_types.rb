class AddAvailableForColumnServiceTypes < ActiveRecord::Migration[5.2]
  def change
  	add_column :service_types, :available_for, :integer
  end
end
