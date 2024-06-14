class CreateRenewalRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :renewal_requests do |t|
      t.references :student, null: false, foreign_key: true
      t.text :reason

      t.timestamps
    end
  end
end
