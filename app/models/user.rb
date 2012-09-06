class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :lastname, :profile_id

  belongs_to :profile
  has_many :logs
  has_many :company_users
  has_many :companies
  has_many :matches

  validates_presence_of :name
  validates_presence_of :lastname
  validates :email, :uniqueness=>true, :format=>{:with=>/\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}
  validates :password, :on=> :create, :presence=>true, :confirmation=>true, :length => {:minimum=>6}
  validates :password_confirmation, :presence=>true, :on=> :create
  validates_associated :profile

  self.per_page = 10

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