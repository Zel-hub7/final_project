class CreateLicenses < ActiveRecord::Migration[7.1]
  def change
    create_table :licenses do |t|
      t.string :license_number
      t.date :expiration_date
      t.references :student, foreign_key: true

      t.timestamps
    end
    
  end
end
