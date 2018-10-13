class AddWxAccountToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :wx_account, :string
    add_column :devices, :wx_pwd, :string
  end
end
