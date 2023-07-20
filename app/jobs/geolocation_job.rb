# frozen_string_literal: true

class GeolocationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    care = Care.find(args.first)
    search_query = [care.address1, care.address2, care.address3, care.city, care.county,
                    care.state, care.country, care.zipcode].compact.join(', ')

    res = Geocoder.search(search_query, lookup: :google)
    if res.empty?
      care.update_columns(map_url: '', lat: '', lng: '')
    else
      geometry = res.first.data.dig('geometry', 'location')
      place_id = res.first.data.dig('place_id')

      place_details = Geocoder.search(place_id, lookup: :google_places_details)
      url = place_details.first.data.dig('url')

      care.update_columns(map_url: url, lat: geometry.dig('lat'), lng: geometry.dig('lng'))
    end

    care.reload

    if care.county.present? && care.state.present? && care.country.present? && care.city.present? & care.map_url.present?
      result = Geocoder.search([care.city, care.county, care.state, care.country].join(', '), lookup: :google)

      if result.present?
        center = result.first.coordinates

        care.update_columns(approx_distance: Geocoder::Calculations.distance_between(center, [care.lat, care.lng], options = { units: :mi }).round(2))
      else
        care.update_columns(approx_distance: 0.0)
      end
    else
      care.update_columns(approx_distance: 0.0)
    end
  end
end
