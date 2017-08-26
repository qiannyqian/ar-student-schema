require_relative '../../db/config'

class Student < ActiveRecord::Base

has_many :teachers

VALID_EMAIL_REGEX = /[a-zA-Z]+@[a-zA-Z]+\.[a-zA-Z]{2,}/
validates :email,
          :presence => {:message => "Enter your email address!" },
          :format => { :with => VALID_EMAIL_REGEX, :message => "Enter a valid Email address !"},
          :uniqueness => {:case_sensitive => false, :message => "Email already exists!"}

# VALID_NUMBER_REGEX = /\d{10}/
# validates :phone,
#           :presence => {:message => "Enter your number" },
#           :format => { :with => VALID_NUMBER_REGEX, :message => "10 digits only!"}

validate :age_limit

  def name
    "#{first_name}" + " " + "#{last_name}"
  end

  def age
    now = Date.today
    age = now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end

  def age_limit
    if age < 5
      errors.add(:base, "Too young to sign up")
    end
  end

end
