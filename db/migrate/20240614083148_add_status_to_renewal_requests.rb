class AddStatusToRenewalRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :renewal_requests, :status, :string, default: "pending"
  end
end
