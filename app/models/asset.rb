# frozen_string_literal: true

class Asset < ApplicationRecord
  has_one_attached :file
  validates_uniqueness_of :sort, scope: %i[assetable_id assetable_type asset_type]
  # Association
  belongs_to :assetable, polymorphic: true
  # Callbacks
  validate :files_count_within_bounds, on: :create

  private

  def files_count_within_bounds
    assets = self.assetable.assets
    if self.asset_type.include?('image')
      image_assets = assets.where('asset_type ILIKE (?)', '%image%')
      if image_assets.size > 10
        errors.add(:file, I18n.t('asset.invalid_files'))
      end
      errors.add(:sort, I18n.t('asset.sort_error')) if sort > 10
      errors.add(:sort, I18n.t('asset.invalid_sort')) if image_assets.pluck(:sort).include? (self.sort)
    elsif self.asset_type.include?('video')
      if assets.where('asset_type ILIKE (?)', '%video%').size > 0
        errors.add(:file, I18n.t('asset.invalid_files'))
      end
    end
  end
end
