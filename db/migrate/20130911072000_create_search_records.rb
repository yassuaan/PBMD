class CreateSearchRecords < ActiveRecord::Migration
  def change
    create_table :search_records do |t|
      t.integer :user_id
      t.string :queri

      t.timestamps
    end
  end
end
