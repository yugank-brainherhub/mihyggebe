class AddNameToLicences < ActiveRecord::Migration[5.2]
  def change
  	add_column :licences, :name, :string
  end
end
