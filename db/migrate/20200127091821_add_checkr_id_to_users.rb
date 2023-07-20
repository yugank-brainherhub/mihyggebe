class AddCheckrIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :checkrId, :string
  end
end
