require 'pubmed_api'

class Search
  def initialize(queri, retmax)
    @epall = Pubmed::EPAll.new
 
    @epall.keyword = queri
    @epall.retmax = retmax
    @epall.use(1)
    
  end
  
  def search
    res = @epall.do
    result = structure(res)
    
    return result
  end
  
  def structure(result)
    response = []
    result.each{|res|
      authors = []
      tmp = [res[:AuthorList]].flatten # return hash when only one author (want to return array)
      tmp.each{|a| authors << a[:Author] }
      publish = res[:PubDate]
      if publish == nil
        publish = 'no information'
      end  
#      Article.create({:pubmed_id => res[:Id], :title => res[:Title], :author => authors.join(', '), :publish => res[:EPubDate]}) 
      response << {:pubmed_id => res[:Id], :title => res[:Title], :author => authors.join(', '), :publish => publish}
    }
    
    return response
  end
    
end