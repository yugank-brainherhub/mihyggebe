class AddCityToCares < ActiveRecord::Migration[5.2]
  def change
    add_column :cares, :city, :string
  end
end
