class AddCategoryToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :category, :string
  end
end
