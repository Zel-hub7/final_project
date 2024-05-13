class AddCategoryToStudentsApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :students_applications, :category, :string
  end
end
