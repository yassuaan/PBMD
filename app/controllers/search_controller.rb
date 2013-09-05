require 'pubmed_api'

class SearchController < ApplicationController
  before_filter :authenticate_user!  

  def result
    retmax = 10
    @retstart = params[:retstart]
    pub = Search.new #(params[:queri], 10)
    pub.epall.keyword = params[:queri]
    pub.epall.retmax = retmax
    
    case params[:page]
    when 'next'
      @retstart = @retstart.to_i + retmax
      
    when 'prev'
      @retstart = @retstart.to_i - retmax
      
    else
      # save queri record
      record = SearchRecord.new({:queri => params[:queri], :username => params[:uname]} )
      record.save
    
    end
  
    pub.epall.esearch.retstart = @retstart
    @articles = pub.search
  
  end
  
  def index
    @record = SearchRecord.find(:all, :conditions => {:username => params[:uname]} )
    @record.reverse!
    
    @uname = params[:uname]
    
  end
  
  def attestation
    if params[:logout]
      redirect_to search_index_path
    end
     
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
