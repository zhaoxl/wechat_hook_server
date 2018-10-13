class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.string      :wx_account_id
      t.string      :wx_account_number
      t.string      :nickname
      t.string      :avator
      t.timestamps
    end
  end
end
