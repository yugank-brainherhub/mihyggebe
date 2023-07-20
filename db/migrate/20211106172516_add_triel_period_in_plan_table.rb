class AddTrielPeriodInPlanTable < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :has_trial_period, :boolean, default: false
    add_column :plans, :trial_number_of_day, :integer, default: 0
    add_column :plans, :nickname, :string
    add_column :plans, :amount, :float
    add_column :plans, :has_bed, :boolean, default: false
  end
end
