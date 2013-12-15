class AgencyAction < ActiveRecord::Base
  belongs_to :agency, touch: true
  belongs_to :action, touch: true
end
