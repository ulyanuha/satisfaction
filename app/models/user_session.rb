class UserSession
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :username, :password, :remember_me

  def initialize(attributes = nil)
    if attributes.kind_of? Hash
      attributes.each do |attribute, value|
        send "#{attribute}=", value if respond_to? "#{attribute}="
      end
    end
  end
  
  def persisted?
    false
  end
end
