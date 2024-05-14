# app/models/students_application.rb
class StudentsApplication < ApplicationRecord
    belongs_to :user
    belongs_to :school
end
  