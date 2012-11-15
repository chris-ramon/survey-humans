class User < ActiveRecord::Base
  after_create :welcome
  after_create :create_subscription

  devise :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable
  #devise :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable 
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :lastname, :profile_id

  belongs_to :profile
  has_many :logs
  has_many :company_users
  has_many :companies
  has_many :matches
  has_many :courses

  #validates_presence_of :name
  #validates_presence_of :lastname
  validates :email, :uniqueness=>true, :format=>{:with=>/\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}
  validates :password, :on=> :create, :presence=>true, :confirmation=>true, :length => {:minimum=>6}
  validates :password_confirmation, :presence=>true, :on=> :create
  validates_associated :profile

  self.per_page = 10

  def welcome 
    SurveyMailer.welcome_to_survey_humans(self).deliver
  end

  def create_subscription
    ### saving customer subscription
    subscription = Panel::Subscription.new
    subscription.User_id = self.id
    plan = Panel::Plan.find_or_create_by_name_and_amount("15 Days Free", 0)
    subscription.panel_plan_id = plan.id
    subscription.expired_at = Time.now + 1296000
    subscription.save

    ### saving credit card information
    billing = Panel::Billing.new
    billing.user_id = self.id
    billing.billing_email = self.email
    billing.save
  end

  # This function evaluates if a column is nullable or not in the database
  #
  # * *args*
  #   - column(_string_) -> database column to be evaluated
  # * *returns*
  #   - if the column is nullable or not
  def self.null?(column)
    columns_hash[column].null
  end

  # This function obtain user fullname
  #
  # * *returns*
  #   - the instanced user fullname
  def fullname
    return "" if name == nil and lastname == nil
    name+" "+lastname
  end

  # This function change user state to deleted
  #
  # * *args*
  #   - id -> user id
  # * *returns*
  #   - if the state update was successful or not
  def self.delete(id)
    return update_all({:deleted=>1, :updated_at=>Time.now},{:id=>id})
  end

  # This functions evaluates if the current user has permission to the specified access
  #
  # * *args*
  #   - access_id(_int_) -> access to be evaluated
  # * *returns*
  #   - if the user has permission or not
  def has_access access_id
    list_access_ids = profile.access_profiles.collect {|x| x.access_id unless x.deleted==1}
    list_access_ids.include? access_id
  end

end