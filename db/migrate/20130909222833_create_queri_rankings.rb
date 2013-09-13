class CreateQueriRankings < ActiveRecord::Migration
  def change
    create_table :queri_rankings do |t|
      t.string :queri
      t.integer :freq

      t.timestamps
    end
  end
end
