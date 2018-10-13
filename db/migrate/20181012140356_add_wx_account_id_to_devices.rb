class AddWxAccountIdToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :wx_account_id, :integer
  end
end
