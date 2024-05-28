# app/models/student.rb

class Student < ApplicationRecord
    belongs_to :user
    belongs_to :school


    has_many :tests, dependent: :destroy

    def failed_exam?
        tests.any? { |test| test.status == 'failed' }
    end
end
  