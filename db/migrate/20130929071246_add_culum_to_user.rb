class AddCulumToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :facebook_id, :string
    add_column :users, :twitter_id, :string
  end
end
