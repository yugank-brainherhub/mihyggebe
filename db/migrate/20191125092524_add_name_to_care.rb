class AddNameToCare < ActiveRecord::Migration[5.2]
  def change
    add_column :cares, :name, :string
  end
end
