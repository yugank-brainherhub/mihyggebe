# frozen_string_literal: true

class API::V1::Search::AutocompleteAction < Abstract::BaseAction
  attr_accessor :care_county, :care_state, :care_city

  def perform
    search = ::Care.care_search(permitted_params[:query]).where("county is not null and city is not null and state is not null")
    @care_county = search#::Care.search_by_county(permitted_params[:query])
    @care_state = search#::Care.search_by_state(permitted_params[:query])
    @care_city = search#::Care.search_by_city(permitted_params[:query])
  end


  def data
    result = []

    # TODO: Not a right place to strip here. Till we change model, we need to fix here
    if care_county.present?
      result << care_county.map do |c|
        { value: c.county.strip.downcase, type: :county }
      end
    end

    if care_state.present?
      result << care_state.map do |c|
        { value: c.state.strip.downcase, type: :state }
      end
    end

    if care_city.present?
      result << care_city.map do |c|
        { value: c.city.strip.downcase, type: :city }
      end
    end

    result.flatten.uniq
  end

  def authorize!
    true
  end

  def permitted_params
    params.require(:search).permit(:query)
  end
end

