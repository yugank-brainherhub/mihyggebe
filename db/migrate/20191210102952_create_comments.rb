class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text   :description
      t.string :comment_type
      t.references :resource, polymorphic: true

      t.timestamps
    end
  end
end
