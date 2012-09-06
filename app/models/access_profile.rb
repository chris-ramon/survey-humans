class AccessProfile < ActiveRecord::Base
  belongs_to :access
  belongs_to :profile

  # This function change user state to deleted
  #
  # * *args*
  #   - id -> profile id
  # * *returns*
  #   - if the state update was successful or not
  def self.delete(id)
    return update_all({:deleted=>1, :updated_at=>Time.now},{:id=>id})
  end
  
end
