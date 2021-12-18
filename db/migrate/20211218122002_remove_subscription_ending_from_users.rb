class RemoveSubscriptionEndingFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :subscription_ending, :date
  end
end
