# frozen_string_literal: true

module Validators
  class BankDetailValidatorCompany
    include ActiveModel::Validations

    attr_accessor :business_type, :day, :month, :year, :ssn, :city, :file1, :file2, :title, :company_name,
                  :line1, :postal_code, :state, :website_url, :description, :routing_number, :bank_account, :phone,
                  :ein

    def initialize(params)
      @business_type = params[:business_type]
      @day = params[:day]
      @month = params[:month]
      @year = params[:year]
      @ssn = params[:ssn]
      @city = params[:city]
      @file1 = params[:file1]
      @file2 = params[:file1]
      @line1 = params[:line1]
      @line2 = params[:line2]
      @postal_code = params[:postal_code].to_i
      @state = params[:state]
      @website_url = params[:website_url]
      @description = params[:description]
      @routing_number = params[:routing_number].to_i
      @bank_account = params[:bank_account].to_i
      @phone = params[:phone].to_i
      @title = params[:title]
      @company_name = params[:company_name]
      @ein = params[:ein].to_i
    end

    present_attr = %i[business_type day month year ssn city file1 file2
                      line1 postal_code state website_url description routing_number
                      bank_account phone title company_name ein]

    integer_mandatory = %i[routing_number bank_account phone postal_code]

    validates_presence_of present_attr

    validates_each :business_type do |record, attr, value|
      if value != 'individual' && value != 'company'
        record.errors.add attr, 'bank type must be individual or company'
      end
    end

    validates_length_of :routing_number, maximum: 9, minimum: 9

    validates_length_of :bank_account, in: 6..16

    validates_length_of :phone, maximum: 10, minimum: 10

    validates_length_of :postal_code, maximum: 5, minimum: 5

    validates_each integer_mandatory do |record, attr, value|
      record.errors.add attr, 'must be number ' if value == 0
    end

    validates_each :ein do |record, attr, value|
      record.errors.add attr, 'must be number ' if value == 0
    end
  end
end
