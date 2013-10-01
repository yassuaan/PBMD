require 'twitter'
require 'pubmed_api'

class SearchController < ApplicationController
  #before_filter :authenticate_user!  

  def result
    unless params[:queri]
      return 'no information'
    end
    
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
      buf_id = check_user_id
      record = SearchRecord.new({:queri => params[:queri], :user_id => buf_id} )
      record.save
    
    end
  
    pub.epall.esearch.retstart = @retstart
    @articles = pub.search
    
    #rankning
    querifreq = QueriRanking.where(:queri => params[:queri])
    if querifreq.length == 0
      QueriRanking.create({:queri => params[:queri], :freq => 1})  
    else
      querifreq.each do |qf|
        qf.update_attribute(:freq, qf.freq+1)
      end
    end
      
  end
  
  def index
    @recort ||= []
    p 'testestssetse'
    p current_user
    
    buf_id = check_user_id
    
    @record = SearchRecord.find(:all, :conditions => {:user_id => buf_id} )  
    @record.reverse!
    
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
  
  def do_tweet
    tuser = OauthTwitter.where(:tuid => User.find(session[:user_id]).twitter_id).first
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token = tuser.token
      config.oauth_token_secret = tuser.stoken
    end
    
    text = convert_size(params[:text])
    Twitter.update(text)
    redirect_to search_detail_path(:pid => params[:pid])
  end
  
  private
  def check_user_id
    if current_user
      buf_id = current_user.id
    else
      buf_id = 0 # 0 is situation that not login
    end
    return buf_id
  end
  
  def convert_size(str)
    str.slice!(0, 120) if str.size > 120
    return str
  end
  
end

