class AddLastActiveAtToWxAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :wx_accounts, :last_active_at, :datetime
  end
end
