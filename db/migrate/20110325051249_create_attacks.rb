class CreateAttacks < ActiveRecord::Migration
  def self.up
    create_table :attacks do |t|
      t.string :attack_name
      t.string :attack_image

      t.timestamps
    end
  end

  def self.down
    drop_table :attacks
  end
end
