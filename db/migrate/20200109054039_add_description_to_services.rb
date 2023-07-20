class AddDescriptionToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :desc, :text
  end
end
