class AddGeolocationToCare < ActiveRecord::Migration[5.2]
  def change
    add_column :cares, :lat, 	 :string, default: ''
    add_column :cares, :lng, 	 :string, default: ''
    add_column :cares, :map_url, :string, default: ''
  end
end
