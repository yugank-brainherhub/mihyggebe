class CreateSelectedServices < ActiveRecord::Migration[5.2]
  def change
   	create_table :selected_services do |t|
      t.references(:care, index: true)
      t.references(:service, index: true)
      t.references(:service_type, index: true)
      t.timestamps
    end
  end
end
