# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'pubmed_api'

=begin
epall = Pubmed::EPAll.new
epall.keyword = 'cancer'
epall.retmax = 5
epall.use(1)

result = epall.do

unless Article.count > 0 then
  result.each{|res|
    authors = []
    res[:AuthorList].each{|a| authors << a[:Author] }
    Article.create({:pubmed_id => res[:Id], :title => res[:Title], :author => authors.join(', '), :publish => res[:EPubDate]}) 
    
  }
end
=end

unless Record.count > 0 then
  Record.create({:queri => 'cancer'})
  
end

unless QueriRanking.count > 0 then
  QueriRanking.create([{:queri => 'cancer', :freq => 30}, {:queri => 'apotosis', :freq => 10}, {:queri => 'sport', :freq => 5}])
end