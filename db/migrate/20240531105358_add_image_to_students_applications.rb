class AddImageToStudentsApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :students_applications, :image, :string
  end
end
