class CreateWxAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :wx_accounts do |t|
      t.string  :wx_id
      t.string  :pwd
      t.string  :state
      t.timestamps
    end
  end
end
