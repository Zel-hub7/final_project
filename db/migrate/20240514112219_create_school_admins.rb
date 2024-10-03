class CreateSchoolAdmins < ActiveRecord::Migration[7.1]
  def change
    create_table :school_admins do |t|
      t.references :school, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
