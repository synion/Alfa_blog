class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ApplicationRecord
  has_many :articles
  before_save { self.email = email.downcase }
  validates :email, presence: true, uniqueness: true, email: true
  validates :name,  presence: true, uniqueness: { case_sensitive: false },
                    length: { minimum: 3, maximum:25 }

end
