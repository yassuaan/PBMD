require 'spec_helper'

describe RankingController do
  before(:each) do
    get 'queri'
  end
  
  describe "GET 'queri'" do
    it "returns http success" do

      expect(response).to be_success
    end
    
    it "check varidance" do
      expected = QueriRanking.find(:all, :order => 'freq desc') 
      
      expect(assigns(:queris)).to eq(expected)
    end
    
  end
    
end
