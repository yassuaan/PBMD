require 'pubmed_api'

class Detail
  attr_accessor :efetch
  
  def initialize
    @efetch = Pubmed::EFetch.new
    
  end
  
  def do
    res = @efetch.do
    result = structure(res)
    
    return result
  end
  
  def structure(origin)
    res = origin[0][:MedlineCitation]
    art = res[:Article]
    authors = []
    art[:AuthorList].each{|a|
       str = a[:Author][:ForeName] + " " + a[:Author][:LastName] 
       authors << str
     }
    abs = art[:Abstract].each{|k, v| v }
    response = {:PMID => res[:PMID],
      :Title => art[:ArticleTitle],
      :AuthorList => authors.join(", "),
      :Abstract => abs[:AbstractText],
      :Journal => art[:Journal][:ISOAbbreviation]
    }
    return response
  end
    
end