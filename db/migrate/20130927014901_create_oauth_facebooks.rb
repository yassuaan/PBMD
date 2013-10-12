class CreateOauthFacebooks < ActiveRecord::Migration
  def change
    create_table :oauth_facebooks do |t|
      t.string :fname
      t.string :code
      t.string :token
      t.string :expires
      t.string :fuid

      t.timestamps
    end
  end
end
