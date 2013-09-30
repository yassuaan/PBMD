require 'spec_helper'


describe "ranking/queri.html.haml" do
  pending "add some examples to (or delete) #{__FILE__}"
  
  before(:each) do
    h = [{:queri => 'cancer', :freq => 3}, {:queri => 'apotosis', :freq => 10}]
    assign(:queris, h)
    
    render

  end
  
  it 'h1 is QueriRanking' do
    rendered.have_selector("h1") do |h1|
      expect(h1).to contain "QueriRanking"
    end
  end
  
end
