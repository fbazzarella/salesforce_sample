class AddSalesforceAuthToUser < ActiveRecord::Migration
  def change
    add_column :users, :salesforce_auth, :hstore
  end
end
