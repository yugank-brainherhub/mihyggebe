# frozen_string_literal: true

module ActionPerformer
  def self.included(base)
    base.send(:include, Uncouple::ActionPerformer)
  end

  def render_action_error(action)
    render json: action.formatted_errors, status: action.error_code
  end
end
