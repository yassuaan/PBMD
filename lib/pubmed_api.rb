#! /usr/local/bin/ruby -Ku

require 'rexml/document'
require 'open-uri'
require 'rubygems'

module Pubmed
  class EPubmed
    P_DATABASE = 'pubmed'
    def do
      @db = P_DATABASE
      @result = nil
      url = create_url
      
      xml = open(url).read 
      
      hash = xml_to_hash(xml, @root_path)
      @result = hash
      return @result
    end

    #about url    
    def create_url
      queri = create_queri
      api = self.class.name.sub!('Pubmed::', '').downcase!
      url = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/'+ api + '.fcgi?' + queri
#      puts url
      return url
      
    end
    
    def create_queri
      arry = []
      instance_variables.each { |var|
        k = var.to_s.tr('@','')
        v = instance_variable_get(var)
        if v.class == Array
          v = v.join(',')
        end
        if k == 'keyword'
          k = 'term'
        end
        arry << "%s=%s" % [k,v]
       }
       return arry.join('&')
    end

 
    # about xml
  
    def xml_to_hash(xml, root_name)
      res = []
#      puts xml
      xml.gsub!(/\n/, '')
      xml.gsub!(/\t/, '')
      xml.gsub!(/>\s+</, '><')
      xml.gsub!(/<\?\S*\?>/, '') #to Efetch
      doc = REXML::Document.new(xml)
      doc.root.get_elements(root_name).collect{|ele|
        hash = xml_deep(ele)
        res << hash
      }
      return res
    end
    
#    private
    
    def xml_deep(xml, h=Hash.new)
      if xml.has_elements?
        arr = []
        xml.children.each{|item|
          if h[decide_key(item)]
            arr << h
            h = Hash.new
          end
          h[decide_key(item)] = xml_deep(item)
        }
        if arr.size > 0
          arr << h
          h = arr
        end
      else
        h = xml.text
      end
      return h
    end

    def decide_key(xml)
      if xml.has_attributes?
        xml.attributes.each{|k, v|
          return v.to_sym if attribute_key(k)
        }
      end
      return xml.name.to_sym
    end

    def attribute_key(key)
      return true if key =~ /Name/
      return false
    end
 
  end
  
  class ESearch < EPubmed
    attr_accessor :keyword
    attr_accessor :retstart #use next
    attr_accessor :retmax
    attr_accessor :rettype
    attr_accessor :datetype
    attr_accessor :mindate, :maxdate
    
    def initialize(keyword=nil)
      @keyword = keyword if keyword
      @root_path = '!DOCTYPE'
    end
    
    def do_output_idlists(res=nil)
      if res == nil
        res = self.do 
      end
      
      buf = [res.first[:IdList]].flatten
      idlist = []
      buf.each{|ids|
        idlist << ids[:Id]      
      }
      return idlist
      
    end
    
  end # class ESearch
  
  class ESummary < EPubmed
    attr_accessor :id
    
    def initialize
      @root_path = 'DocSum'
    end
    
  end # class ESummary

  class EFetch < EPubmed
    attr_accessor :id
    
    def initialize
      @retmode = 'xml'
      @root_path = 'PubmedArticle'
    end
    
    def abst(id)
      @id = id
      self.do
      tmp = @result.first[:MedlineCitation][:Article][:Abstract]
      abst = ''
      case tmp
      when ::Hash
        abst = tmp[:AbstractText]
        
      when ::Array
        tmp.each{|buf|
          abst += buf[:AbstractText]
        }
        
      end
      return abst
      
    end


  end # class EFetch
  
  class ESpell < EPubmed
    attr_accessor :keyword
    
    def initialize
      @retmode = 'xml'
      @root_path = '!DOCTYPE'
    end

    
  end # class ESpell
  
  class EPAll
    RET_MAX = 10
    attr_accessor :keyword ,:retmax
    attr_accessor :esearch
    
    def initialize(keyword=nil)
      @keyword = keyword if keyword
      @retmax = RET_MAX
      @esearch = ESearch.new
      @esummary = ESummary.new
      @efetch = EFetch.new
      
    end
    
    def do
      @esearch.keyword = @keyword
      @esearch.retmax = @retmax
      idlist = @esearch.do_output_idlists
      details = []

      idlist.each{|id| details << Detail.new(id) }
      
      return details
    end
    
  end
  
  class Detail
    attr_reader :id, :detail
    
    def initialize(id)
      @id = id
      
    end
    
    def create_detail
      esummary = ESummary.new
      efetch = EFetch.new
      
      esummary.id = @id
      result = esummary.do
      #efetch.id = @id
      #result = efetch.do
      
      #abst = efetch.abst(@id)
      
      #@detail = result.first.merge(:abst => abst)
      @detail = result.first
    end
    
  end
    
end
