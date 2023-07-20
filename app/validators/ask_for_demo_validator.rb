# frozen_string_literal: true

module Validators
  class AskForDemoValidator
    include ActiveModel::Validations

    attr_accessor :email, :name, :title, :phone, :date, :time_zone, :time, :additional

    def initialize(params)
      @name = params[:name]
      @email = params[:email]
      @title = params[:title]
      @phone = params[:phone]
      @date = params[:date]
      @time_zone = params[:time_zone]
      @time = params[:time]
      @additional = params[:additional]
    end

    validates_presence_of :email, :name, :title, :date, :time_zone, :time

    validates_length_of :phone, maximum: 13, minimum: 10

    validates_numericality_of :phone

    validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

    validates_each :date do |record, attr, value|
      Date.parse(value) rescue record.errors.add attr, 'invalid date'
    end

    validates_each :time do |record, attr, value|
      value.to_time.strftime("%H:%M") == value rescue record.errors.add attr, 'time must be in HH:MM format'
    end
  end
end
