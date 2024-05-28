class AddStatusToTests < ActiveRecord::Migration[7.1]
  def change
    add_column :tests, :status, :string
  end
end
