# app/models/school_admin.rb

class SchoolAdmin < ApplicationRecord
    belongs_to :user
    belongs_to :school

    validates :user_id, presence: true
end
  