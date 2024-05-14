class School < ApplicationRecord
    has_many :students_applications
    has_many :students
end
