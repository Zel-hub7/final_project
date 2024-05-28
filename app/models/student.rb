# app/models/student.rb

class Student < ApplicationRecord
    belongs_to :user
    belongs_to :school

    has_many :tests, dependent: :destroy
end
  