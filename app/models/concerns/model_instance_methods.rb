module ModelInstanceMethods
  extend ActiveSupport::Concern

  included do
    before_save :set_slug 
  end
  
  def set_slug
    self.slug = self.name.downcase.gsub('.','').gsub(' ','-')
  end
end