# app/models/reexam.rb
class Reexam < ApplicationRecord
    belongs_to :student
  
    validates :full_name, presence: true
end
  