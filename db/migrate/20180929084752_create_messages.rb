class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string      :device_id
      t.string      :talker
      t.string      :msg_type
      t.text        :raw
      t.text        :content
      t.bigint     :create_time
      t.boolean     :is_send
      t.string      :md5
      t.string      :image
      t.string      :voice
      t.string      :video
      t.timestamps
    end
  end
end
