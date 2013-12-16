class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password,
    :password_confirmation, :remember_me, :stripe_token, :coupon,
    :address, :city, :state, :zipcode, :country


  validates :first_name, :last_name, :email, :address, :city,
    :state, :zipcode, :country, presence: true

  validates :email, uniqueness: true

  has_many :comments

  attr_accessor :stripe_token, :coupon

  before_save :update_stripe

  after_create :send_welcome
#  before_destroy :cancel_subscription

  def update_plan(role)
    self.role_ids = []
    self.add_role(role.name)
    unless customer_id.nil?
      # customer = Stripe::Customer.retrieve(customer_id)
      # customer.update_subscription(:plan => role.name)
    end
    true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end

  def update_stripe
    return if self.has_role? :admin
    return if email.include?('@example.com') and not Rails.env.production?
    if customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end
        customer = Stripe::Customer.create(
          :email => email,
          :description => full_name,
          :card => stripe_token
        )
    else
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_token.present?
        customer.card = stripe_token
      end
      customer.email = email
      customer.description = full_name
      customer.save
    end
    self.last_4_digits = customer.cards.data.first["last4"]
    self.customer_id = customer.id
    self.stripe_token = nil


  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    false
  end

=begin
  def cancel_subscription
    unless customer_id.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      unless customer.nil? or customer.respond_to?('deleted')
        if customer.subscription.status == 'active'
          customer.cancel_subscription
        end
      end
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
  end
=end

  def expire
    UserMailer.expire_email(self).deliver
    destroy
  end

  def full_name
    first_name + last_name
  end

  def self.avatar_url email
    hash = Digest::MD5.hexdigest(email.strip)
    "http://www.gravatar.com/avatar/#{hash}?s=200&d=mm"
  end

  private

    def send_welcome
      UserMailer.signup_email(self).deliver
    end

end
