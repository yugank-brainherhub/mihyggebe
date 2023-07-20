class RenameNoOfBedroomsBedsCareDetails < ActiveRecord::Migration[5.2]
  def change
  	rename_column :care_details, :no_of_bedrooms, :no_of_beds
  end
end
