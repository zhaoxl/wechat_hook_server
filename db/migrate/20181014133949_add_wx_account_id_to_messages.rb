class AddWxAccountIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :wx_account_id, :integer
  end
end
