class ChangeBedNumberDatatype < ActiveRecord::Migration[5.2]
  def change
  	change_column :beds, :bed_number, :string
  end
end
