# db/migrate/[timestamp]_create_students_application.rb

class CreateStudentsApplication < ActiveRecord::Migration[7.1]
  def change
    create_table :students_applications do |t|
      t.references :user, foreign_key: true
      t.string :status, default: 'pending'
      t.string :FirstName
      t.string :LastName
      t.string :phone_number

      t.timestamps
    end
  end
end
