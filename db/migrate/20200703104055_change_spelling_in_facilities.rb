class ChangeSpellingInFacilities < ActiveRecord::Migration[5.2]
  def change
    Facility.find_by(name: 'Private Guide Tour')&.update(name: 'Online Tour')
  end
end
