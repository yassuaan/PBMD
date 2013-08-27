class CreateUserAttestations < ActiveRecord::Migration
  def change
    create_table :user_attestations do |t|
      t.string :user_id
      t.string :password

      t.timestamps
    end
  end
end
