class AddOrderToAssets < ActiveRecord::Migration[5.2]
  def change
    add_column :assets, :sort, :integer
  end
end
