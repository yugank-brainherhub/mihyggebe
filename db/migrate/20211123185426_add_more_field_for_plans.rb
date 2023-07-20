class AddMoreFieldForPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :is_yearly, :boolean, default: false
  end
end
