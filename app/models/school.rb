class School < ApplicationRecord
    has_many :students_applications
    has_many :students
    has_many :school_admins
    has_many :admins, through: :school_admins, source: :user

end
