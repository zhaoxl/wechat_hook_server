class AddClientVersionToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :client_version, :string
  end
end
