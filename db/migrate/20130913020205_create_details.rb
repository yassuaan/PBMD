class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|

      t.timestamps
    end
  end
end
