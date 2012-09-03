# Special columns
#
# * _panel_ -> indicates if is going to be shown in the panel
#   - 0 -> to be shown
#   - 1 -> not show
class Access < ActiveRecord::Base
  
  has_many :access_profiles
  
  # This functions create an access from a attributes hash including the id.
  # This function should be used only in seeds.
  #
  # * *args*
  #   - attributes -> hash of attributes
  def self.create_migration(attributes = nil)
    access_tmp = Access.new(attributes)
    access_tmp.id = attributes[:id]
    access_tmp.save!
    access_tmp.reload
  end

  #This function generates a string of childs access id. This is generated for javascript porpouses
  #
  # * *returns*
  #   - childs access ids string comma separated
  def get_childs
    access = Access.where(:parent_id=>id)
    childs=""
    access.each do |item|
      if childs.empty?
        if item.get_childs.empty?
          childs=item.id.to_s
        else
          childs=item.id.to_s+","+item.get_childs
        end
      else
        if item.get_childs.empty?
          childs= childs+","+item.id.to_s
        else
          childs= childs+","+item.id.to_s+","+item.get_childs.to_s
        end
      end
    end
    return childs
  end

  #This function generates a string of child parents ids. This is generated for javascript porpouses
  #
  # * *returns*
  #   - parents access ids string comma separated
  def get_parents
    parents=""
    parent_id_aux= parent_id
    while parent_id_aux!=0
      access = Access.find(parent_id_aux)
      if parents.empty?
        parents = access.id.to_s
      else
        parents = parents+","+access.id.to_s
      end
      parent_id_aux = access.parent_id
    end
    return parents
  end

  #This function checks if the access has childs
  #
  # * *returns*
  #   - a boolean whether the access has childs or not 
  def has_childs
    access = Access.where(:parent_id=>id).first
    if access.blank?
      return false
    else
      return true
    end
  end

end
