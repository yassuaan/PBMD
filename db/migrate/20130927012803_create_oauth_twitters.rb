class CreateOauthTwitters < ActiveRecord::Migration
  def change
    create_table :oauth_twitters do |t|
      t.string :tname
      t.string :token
      t.string :stoken
      t.string :tuid

      t.timestamps
    end
  end
end
