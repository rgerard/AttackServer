class AddDeviceTokenToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :device_token, :string
  end

  def self.down
    remove_column :users, :device_token
  end
end
