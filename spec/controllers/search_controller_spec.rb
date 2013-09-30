require 'spec_helper'


describe SearchController do

  before(:all) do
    @user = FactoryGirl.create(:user)
    @user.save!
    @different_user = FactoryGirl.create(:user)
    @different_user.save!  #.confirm!
    FactoryGirl.create(:search_record)
    10.times{FactoryGirl.create(:search_record)}
  end

  describe "GET 'index'" do
    it "returns http success" do      
      get 'index'
      expect(response).to be_redirect
    end
    
    it "check variable." do
      sign_in :user, @user
      
      exrecord = SearchRecord.find(:all, :conditions => {:user_id => @user.id} )
      exrecord.reverse!
      get "index"
      
      expect(assigns(:record)).to eq(exrecord)
    end
    
  end
  
  describe "GET 'result'" do
    QUERI = 'cancer'
    RETSTART = 0
    
    before(:each) do
      sign_in :user, @user
      
      retmax = 10
      @pub = Search.new #(params[:queri], 10)
      @pub.epall.keyword = QUERI
      @pub.epall.retmax = retmax
    
    end
    
    it "returns http success" do
      get 'result'
      expect(response).to be_success
    end
    
    it "check article" do      
      expected = @pub.search
      c = []
      expected.each{|b| 
        a={}
        b.each{|k, v|
           a[k.to_s] = v
          } 
          c << a
         
        }
        
      get :result, {:queri => QUERI, :retstart => 0 }
      
      expect(assigns(:articles)).to eq(c)
    end
    
    it "check next" do
      get :result, {:page => 'next', :retstart => 0 , :queri => QUERI}
      
      expected = 10
      
      expect(assigns(:retstart)).to eq(expected)
      
    end
    
    it "check prev" do
      get :result, {:page => 'prev', :retstart => 30 , :queri => QUERI}
      
      expected = 20
      
      expect(assigns(:retstart)).to eq(expected)      
    end
    
  end
    
  describe "GET 'detail'" do
    it "returns http success" do
      get 'detail'
      expect(response).to be_redirect
    end
    
    it "check variable" do
      sign_in :user, @user
      
      fetch = Detail.new
      fetch.efetch.id = 24024136
      exdetails = fetch.do
      a = {}
      exdetails.each{|k, v| a[k.to_s] = v}
      
      get :detail, {:pid => 24024136}
      
      expect(assigns(:details)).to eq(a)
    end
    
  end

end
