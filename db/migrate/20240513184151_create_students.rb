class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :FirstName
      t.string :LastName
      t.string :phone_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
