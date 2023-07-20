class AddBedsCountCounterCacheToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :beds_count, :integer, default: 0
  end
end
