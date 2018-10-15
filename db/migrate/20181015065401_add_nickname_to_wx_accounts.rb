class AddNicknameToWxAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :wx_accounts, :nickname, :string
  end
end
