# frozen_string_literal: true

class User < ApplicationRecord
  enum status: %i[pending approved rejected]
  enum checkr_status: %i[checkr_pending checkr_approved checkr_rejected]

  has_secure_password
  # validations
  validates :first_name, :last_name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :first_name, :last_name, :profession,
            format: { with: /^[a-zA-Z.\s]*$/, multiline: true, message: I18n.t('user.name_error') }
  validates :email, uniqueness: true, presence: true, length: { minimum: 3, maximum: 60 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, on: :create
  validates :password, :password_confirmation, presence: true,
                                               length: { minimum: 6, maximum: 20 }, confirmation: true, on: :create
  validates_length_of :mobile, allow_nil: true, maximum: 13, numericality: true
  validates :above18, acceptance: { accept: true }, on: :create, allow_nil: false

  # Associations
  belongs_to :role
  has_many :subscriptions, dependent: :destroy
  has_many :cares, dependent: :destroy
  has_many :comments, dependent: :destroy, as: :resource
  has_many :wishlists, dependent: :destroy
  has_many :wlcares, :through => :wishlists, :source => :care

  accepts_nested_attributes_for :comments, allow_destroy: true

  # callbacks
  before_create :confirmation_token, :add_provider_status

  def generate_password_token!
    self.attributes = { reset_password_token: generate_token,
                        reset_password_sent_at: Time.current }
    save(validate: false)
  end

  def password_token_valid?
    (reset_password_sent_at + 4.hours) > Time.current
  end

  def reset_password!(password)
    self.attributes = { password: password, password_confirmation: password }
    save
  end

  def activate_email
    self.attributes = { email_confirmed: true, confirm_token: nil }
    save(validate: false)
  end

  def provider?
    role.name == 'provider'
  end

  def customer?
    role.name == 'customer'
  end

  def social_worker?
    role.name == 'social_worker'
  end

  def admin?
    role.name == 'admin'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def add_provider_status
    self.status = provider? ? :pending : :approved
  end

  def self.users_applicable_for_checker_charge
    User.includes(:cares).where(cares: { status: 'active' }).where(checker_future_payment: Date.today)
  end

  def self.admin_users
    User.where(role: Role.find_by(name: 'admin'))
  end

  def self.provider_users
    User.where(role: Role.find_by(name: 'provider'))
  end

  def self.customer_users
    User.where(role: Role.find_by(name: 'customer'))
  end

  def self.social_worker
    User.where(role: Role.find_by(name: 'social_worker'))
  end

  def self.user_with_incomplete_checkr
    User.where.not(checkrId: nil).where(invitation_status: '')
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end

  def confirmation_token
    if confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def self.users_with_care_as_pending
    joins(:cares).where(email_sent: false).where(cares: { status: 'pending' }).where('cares.created_at <= ?', Time.now - 0.5.hours)
  end
end
