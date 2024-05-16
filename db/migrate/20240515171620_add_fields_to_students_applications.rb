class AddFieldsToStudentsApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :students_applications, :middle_name, :string, null: true
    add_column :students_applications, :gender, :string
    add_column :students_applications, :birthday, :date
    add_column :students_applications, :address, :string
    add_column :students_applications, :city, :string
  end
end
