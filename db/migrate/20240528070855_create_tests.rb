class CreateTests < ActiveRecord::Migration[7.1]
  def change
    create_table :tests do |t|
      t.references :student, null: false, foreign_key: true
      t.integer :theory_exam
      t.integer :practical_exam

      t.timestamps
    end
  end
end
