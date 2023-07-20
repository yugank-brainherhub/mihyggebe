class CreateTestimonials < ActiveRecord::Migration[5.2]
  def change
    create_table :testimonials do |t|
      t.string :name
      t.text :description
      t.boolean :publish
      t.string :testimonial_type
      t.string :location
      t.string :gender

      t.timestamps
    end
  end
end
