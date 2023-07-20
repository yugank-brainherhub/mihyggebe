class AddUserReferenceToCares < ActiveRecord::Migration[5.2]
  def change
    add_reference :cares, :user, foreign_key: true
  end
end
