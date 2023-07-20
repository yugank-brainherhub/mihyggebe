# frozen_string_literal: true

require 'navigation_helper.rb'
module ApplicationHelper
  include NavigationHelper

  # This will assign the correct bootstrap colors to the messages
  def flash_class(name)
    case name
    when 'notice' then 'alert alert-info alert-dismissable fade show'
    when 'success' then 'alert alert-success alert-dismissable fade show'
    when 'error' then 'alert alert-danger alert-dismissable fade show'
    when 'alert' then 'alert alert-danger alert-dismissable fade show'
    else
      'alert alert-primary alert-dismissable fade show'
    end
  end

  # Exlude these messages from appearing
  def flash_blacklist(name)
    %w[timedout].include?(name)
  end
end
