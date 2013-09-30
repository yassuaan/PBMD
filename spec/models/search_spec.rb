require 'spec_helper'

describe Search do
  before(:each) do
    @pub = Search.new #(params[:queri], 10)
    @pub.epall.keyword = 'cancer'
    @pub.epall.retmax = 2
    @pub.epall.esearch.mindate = 2010
    @pub.epall.esearch.maxdate = 2011
    
  end
    
  context "search" do
    it "return result" do
      expected = [{:pubmed_id=>"22207909", :title=>"Different imaging modalities in detection of a huge intracardiac mass.", :author=>"Cakal S, Cakal B, Alici G, Ozkan B, Bulut M, Esen AM", :publish=>"2011 Dec"}, {:pubmed_id=>"22207908", :title=>"The ACT-ONE trial, a multicentre, randomised, double-blind, placebo-controlled, dose-finding study of the anabolic/catabolic transforming agent, MT-102 in subjects with cachexia related to stage III and IV non-small cell lung cancer and colorectal cancer: study design.", :author=>"Stewart Coats AJ, Srinivasan V, Surendran J, Chiramana H, Vangipuram SR, Bhatt NN, Jain M, Shah S, Ali IA, Fuang HG, Hassan MZ, Beadle J, Tilson J, Kirwan BA, Anker SD", :publish=>"2011 Dec"}]

      expect(@pub.search).to eq(expected)
      
    end
    
  end
  
  context "structure" do
    it "result convert to use" do
      expected = [{:pubmed_id=>"22207909", :title=>"Different imaging modalities in detection of a huge intracardiac mass.", :author=>"Cakal S, Cakal B, Alici G, Ozkan B, Bulut M, Esen AM", :publish=>"2011 Dec"}, {:pubmed_id=>"22207908", :title=>"The ACT-ONE trial, a multicentre, randomised, double-blind, placebo-controlled, dose-finding study of the anabolic/catabolic transforming agent, MT-102 in subjects with cachexia related to stage III and IV non-small cell lung cancer and colorectal cancer: study design.", :author=>"Stewart Coats AJ, Srinivasan V, Surendran J, Chiramana H, Vangipuram SR, Bhatt NN, Jain M, Shah S, Ali IA, Fuang HG, Hassan MZ, Beadle J, Tilson J, Kirwan BA, Anker SD", :publish=>"2011 Dec"}]      
      res = @pub.epall.do
      
      expect(@pub.structure(res)).to eq(expected)
    end
  end
  
end
