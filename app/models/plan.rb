# frozen_string_literal: true

class Plan < ApplicationRecord
  enum status: %i[active inactive]
  has_many :packages, dependent: :destroy
  has_many :subscriptions, dependent: :destroy, through: :packages
  
  validates_uniqueness_of :planId
  

  def self.plan_only_for_checker
    where('id = ?', id).first
  end

  def self.plan_only_for_doc_sign
    where('id = ?', id).first
  end


  def self.plan_according_id(id)
    where('id = ?', id).first
  end

  def self.plan_according_bed(bed)
    where(:is_yearly => true).where('min <= ?', bed).where('max >= ?', bed).active.first
  end
  def self.plan_according_bed_last(bed)
    where(:is_yearly => true).where('min <= ?', bed).where('max >= ?', bed).active.last
  end
  def self.monthly_plan_according_bed_last(bed)
    where(:is_yearly => false).where('min <= ?', bed).where('max >= ?', bed).active.last
  end
  def self.yearly_plan_according_bed_last(bed)
    where(:is_yearly => true).where('min <= ?', bed).where('max >= ?', bed).active.last
  end

end
