class AddSchoolRefToStudentsApplications < ActiveRecord::Migration[7.1]
  def change
    add_reference :students_applications, :school, foreign_key: true
  end
end
