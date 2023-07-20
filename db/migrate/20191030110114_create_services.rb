class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name, index: true
      t.references(:service_type, index: true)
      t.timestamps
    end
  end
end
