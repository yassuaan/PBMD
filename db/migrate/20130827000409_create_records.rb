class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :queri

      t.timestamps
    end
  end
end
