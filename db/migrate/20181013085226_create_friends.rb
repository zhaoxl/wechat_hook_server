class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.string      :account_id
      t.string      :wx_id
      t.string      :nickname
      t.string      :avator
      t.timestamps
    end
  end
end
