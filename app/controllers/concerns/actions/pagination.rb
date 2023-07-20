# frozen_string_literal: true

module Actions
  module Pagination
    def paginated_records
      @paginated_records ||= if records.is_a?(Array)
                               Kaminari.paginate_array(records)
                             else
                               records
      end.page(page).per(per)
    end

    def page
      params[:page] || 1
    end

    def per
      params[:per_page] || 20
    end

    def paginate_metadata
      {
        'current-page': paginated_records.current_page,
        'next-page': paginated_records.next_page,
        'prev-page': paginated_records.prev_page,
        'per_page': paginated_records.limit_value,
        'total-pages': paginated_records.total_pages,
        'total-records': paginated_records.total_count
      }
    end
  end
end
