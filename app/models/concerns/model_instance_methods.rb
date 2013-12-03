module ModelInstanceMethods
  extend ActiveSupport::Concern

  included do
    before_save :set_slug 
  end
  
  def set_slug
    self.slug = self.name.downcase.gsub('.','').gsub(' ','-')
  end

  def find_clients_and_payments
    client_payments_hash = {}  #key: client.name value: action.payment_sum
    self.actions.uniq.sort_by { |action| action.client.name }.each do |action|
      if !client_payments_hash.keys.include?(action.client.name) 
        client_payments_hash[action.client.name] = action.payment
      else 
        client_payments_hash[action.client.name] += action.payment
      end
    end
    client_payments_hash
  end

  def find_agencies
    self.actions.map do |action|
      action.agencies
    end.flatten.uniq.length
  end
end