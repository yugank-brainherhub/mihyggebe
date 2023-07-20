class Renamecolumnuser < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :above_18?, :above18
  	rename_column :users, :messanger_id, :messenger
  end
end
