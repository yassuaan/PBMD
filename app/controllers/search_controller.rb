require 'pubmed_api'

class SearchController < ApplicationController
  def result
    pub = Search.new(params[:queri], 10)
    @articles = pub.search
    
  end
end
