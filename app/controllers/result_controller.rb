class ResultController < ApplicationController
  def show
    @articles = Article.find(:all)
  end
end
