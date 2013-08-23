class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :pubmed_id
      t.string :title
      t.string :author
      t.string :publish

      t.timestamps
    end
  end
end
