class Article < ActiveRecord::Base
  attr_accessible :author, :publish, :pubmed_id, :title
end
