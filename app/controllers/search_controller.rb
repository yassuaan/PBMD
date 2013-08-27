require 'pubmed_api'

class SearchController < ApplicationController
  def result
    pub = Search.new(params[:queri], 10)
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
    
    
  end
    
end
