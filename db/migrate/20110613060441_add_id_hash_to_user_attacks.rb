class AddIdHashToUserAttacks < ActiveRecord::Migration
  def self.up
    add_column :user_attacks, :id_hash, :string
  end

  def self.down
    remove_column :user_attacks, :id_hash
  end
end
