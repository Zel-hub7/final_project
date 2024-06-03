# app/models/license.rb

class License < ApplicationRecord
    belongs_to :student
  
    validates :license_number, presence: true
    validates :expiration_date, presence: true
end
  