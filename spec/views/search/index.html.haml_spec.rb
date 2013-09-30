require 'spec_helper'


describe "search/index.html.haml" do
  before do
    assign(:record, [{:queri => "cancer"}, {:queri => "cancer"}, {:queri => "apotosis"}])
    
    render
    
  end
  
  it "has title" do
    expect(response.have_tag('h1')).to eq('Search')
  end
  
  
  context 'record' do
    it "has" do
      expect(assigns(:record)).to have(3).queri
    end
    
  end
  
end
