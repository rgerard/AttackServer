class CreateUserAttacks < ActiveRecord::Migration
  def self.up
    create_table :user_attacks do |t|
      t.integer :attacker_id
      t.integer :victim_id
      t.references :attack
      t.string :message
      t.timestamp :created_at
      t.boolean :action_taken
      t.boolean :email_sent
      t.boolean :push_sent

      t.timestamps
    end
  end

  def self.down
    drop_table :user_attacks
  end
end
