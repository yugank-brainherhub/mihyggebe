class CreateAssets < ActiveRecord::Migration[5.2]
  def change
    create_table :assets do |t|
      t.string :asset_type
      t.references :assetable, polymorphic: true
      t.timestamps
    end
  end
end
