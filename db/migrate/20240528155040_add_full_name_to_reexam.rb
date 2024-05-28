class AddFullNameToReexam < ActiveRecord::Migration[7.1]
  def change
    add_column :reexams, :full_name, :string
    change_column_default :reexams, :status, from: nil, to: 'pending'
  end
end
