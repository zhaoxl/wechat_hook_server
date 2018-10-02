class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string  :unique_id
      t.string  :name
      t.string  :state
      t.timestamps
    end
  end
end
