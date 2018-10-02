class CreateRemittanceRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :remittance_records do |t|
      t.references  :device
      t.references  :message
      t.string      :msg_id
      t.string      :talker
      t.float       :feedesc
      t.string      :state
      t.text        :content
      t.bigint      :create_time
      t.boolean     :is_send
      t.timestamps
    end
  end
end
