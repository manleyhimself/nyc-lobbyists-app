class AgencyAction < ActiveRecord::Base
  belongs_to :agency
  belongs_to :action
end
