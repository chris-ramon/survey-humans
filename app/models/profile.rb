class Profile < ActiveRecord::Base
  has_many :users
  has_many :access_profiles

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  validate :check_accesses

  after_update :save_accesses

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

  # This function change user state to deleted
  #
  # * *args*
  #   - id -> profile id
  # * *returns*
  #   - if the state update was successful or not
  def self.delete(id)
    return update_all({:deleted=>1, :updated_at=>Time.now},{:id=>id})
  end

  # This function saves all the related access after a profile creation
  def save_accesses
    access_profiles.each do |access_profile|
      access_profile.save(:validate => false)
    end
  end

  # This function validates if a profile has at least one access related, and if not adds a error message to the ActiveRecord errors array
  def check_accesses
    errors[:base] << I18n.t('messages.at_least_one_access') if access_profiles.find_all {|t| t.deleted == 0}.size == 0
  end
  
  def self.has_users(id)
      users=Profile.find(id).users
      if users.size>0
        return true
      else
        return false  
      end
  end


end
