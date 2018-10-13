class RemoveWxAccountFromDevices < ActiveRecord::Migration[5.2]
  def change
    remove_column :devices, :wx_account
    remove_column :devices, :wx_pwd
  end
end
