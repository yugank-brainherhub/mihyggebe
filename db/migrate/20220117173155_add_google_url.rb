class AddGoogleUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :google_meet_url, :string
  end
end
