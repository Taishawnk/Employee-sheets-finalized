class Employee < ActiveRecord::Base
    has_many :customers
    has_secure_password
end
