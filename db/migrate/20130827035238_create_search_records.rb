class CreateSearchRecords < ActiveRecord::Migration
  def change
    create_table :search_records do |t|
      t.string :queri
      t.string :username

      t.timestamps
    end
  end
end
