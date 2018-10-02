class AddMsgIdToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :msg_id, :integer
  end
end
