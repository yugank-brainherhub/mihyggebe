# frozen_string_literal: true

module NavigationHelper
  def collapsible_links_partial_path
    if current_user.present?
      'layouts/navigation/collapsible_elements/signed_in_links'
    else
      'layouts/navigation/collapsible_elements/non_signed_in_links'
    end
  end
end
