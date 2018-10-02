class CreateWalletLuckyMoneys < ActiveRecord::Migration[5.2]
  def change
    create_table :wallet_lucky_moneys do |t|
      t.references  :device
      t.string      :talker
      t.string      :hb_status
      t.string      :hb_type
      t.string      :receive_status
      t.bigint      :receive_time
      t.bigint      :receive_amount
      t.text        :content
      t.timestamps
    end
  end
end
