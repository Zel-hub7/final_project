# app/models/student.rb

class Student < ApplicationRecord
    belongs_to :user
    belongs_to :school
    has_many :tests, dependent: :destroy
    has_many :reexams, dependent: :destroy
    has_one_attached :profile_picture
  
    # Validation to limit the number of reexams to three
    validate :validate_reexams_limit
    scope :completed_session, -> { where(session: 'completed') }
    
  
    def failed_exam?
      tests.any? { |test| test.status == 'failed' }
    end
  
    private
  
    def validate_reexams_limit
      if reexams.count >= 3
        errors.add(:base, "Maximum of three reexams allowed")
      end
    end
end
  