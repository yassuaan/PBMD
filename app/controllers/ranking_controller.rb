class RankingController < ApplicationController
  
  def queri
    @queris = QueriRanking.find(:all, :order => 'freq desc') 
    
    
  end
  
end
