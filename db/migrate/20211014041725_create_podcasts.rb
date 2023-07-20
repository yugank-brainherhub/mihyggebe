class CreatePodcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.text :description
      t.string :artwork_image
      t.boolean :publish

      t.timestamps
    end
  end
end
