require 'pubmed_api'

class SearchController < ApplicationController
  def result
    #@retmax = 10
    pub = Search.new #(params[:queri], 10)
    pub.epall.keyword = params[:queri]
    pub.epall.retmax = @retmax
    pub.epall.esearch.retstart = 20
    
    @articles = pub.search
    
    # save queri record
    record = SearchRecord.new({:queri => params[:queri], :username => params[:uname]} )
    record.save
    
  end
  
  def index
    @record = SearchRecord.find(:all, :conditions => {:username => params[:uname]} )
    @record.reverse!
    
    @uname = params[:uname]
    
  end
  
  def attestation    
    att = Attestation.new
    att.requestId = params[:userid]
    att.requestPass = params[:password]
    
    @att_sent = att.attestation
    if att.username
      redirect_to search_index_path(:uname => att.username)
    end
    
  end
    
  def newuser
    @user = UserAttestation.new({:user_id => params[:userid], :password => params[:password]})
    @user.save
    
    redirect_to search_index_path
    
  end
    
  def detail
    fetch = Detail.new
    fetch.efetch.id = params[:pid]
    
    @details = fetch.do
    
  end
    
end
