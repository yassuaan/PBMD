#! /usr/local/bin/ruby -Ku

require 'rexml/document'
require 'open-uri'
require 'rubygems'
#require 'active_support/core_ext'

module Pubmed
  class EPubmed
    def do
      @result = nil
      url = create_url
      
      xml = open(url).read 
      
      hash = xml_to_hash(xml, @root_path)
      @result = hash
      return @result
    end

    private

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
    attr_accessor :retstart
    attr_accessor :retmax
    attr_accessor :rettype
    attr_accessor :datetype
    attr_accessor :mindate, :maxdate
    
    def initialize
      @db = "pubmed"
      @keyword
      @retstart = 0  # use next
      @retmax 
      @rettype
      @datetype
      @mindate
      @maxdate
      @root_path = '!DOCTYPE'
    end
    
    def do_output_idlists(res=nil)
      if res == nil
        res = self.do 
      end
      
      idlist = []
      res.first[:IdList].each{|ids|
        idlist << ids[:Id]
      
      }
#      puts idlist
      return idlist
    end
    
    def page_do(next_page=true , res_type=2)
      idlist = self.do_output_idlists
      if next_page
        @retstart += @retmax
      else
        @retstart -= @retmax
      end
      
#      puts @retstart
      
      if res_type == 1
        result = self.do
      elsif res_type == 2
        result = self.do_output_idlists
      end
      
      return result
    end
    
  end # class ESearch
  
  class ESummary < EPubmed
    attr_accessor :id
    
    def initialize
      @db = "pubmed"
      @id 
      @root_path = 'DocSum'
    end
    
  end # class ESummary

  class EFetch < EPubmed
    attr_accessor :id
    
    def initialize
      @db = "pubmed"
      @id 
      @retmode = 'xml'
      @root_path = 'PubmedArticle'
    end
    
    def abst
      abst = []
      @result[0][:MedlineCitation][:Article][:Abstract].each{|k| abst << k[:AbstractText] }
      #abst = @result.first[:MedlineCitation][:Article][:Abstract][:AbstractText]
      res = abst.join("")
      return res
    end
    
  end # class EFetch
  
  class ESpell < EPubmed
    attr_accessor :keyword
    
    def initialize
      @db = "pubmed"
      @keyword
      @retmode = 'xml'
      @root_path = '!DOCTYPE'
    end

    
  end # class ESpell
  
  class EPAll #< EPubmed
    attr_accessor :keyword ,:retmax
    attr_accessor :esearch
    
    def initialize
      @esearch = ESearch.new
      
      @keyword
      @retmax = 20
      @root_path = '!DOCTYPE'
    end
    
    def use(api=1)
      if api == 1
        @eapi = ESummary.new
      elsif api == 2
        @eapi = EFetch.new
      end
#      print("use : ", @eapi.class, "\n")
    end
    
    def do
      @esearch.keyword = @keyword
      @esearch.retmax = @retmax
      idlist = @esearch.do_output_idlists
      
      return api_do(idlist)
    end
    
    def next
      idlist = @esearch.page_do(true)
      
      return api_do(idlist)
    end
    
    def prev
      idlist = @esearch.page_do(false)
      
      return api_do(idlist)
    end
    
    def api_do(idlist)
      @eapi.id = idlist
      result = @eapi.do
      return result
    end
    
    def search_check
      return @esearch.do
    end
    
  end
  
end

#=begin
epall = Pubmed::EFetch.new
epall.id = '23272249'
epall.do
abs = epall.abst
puts abs
#=end
#epall.keyword = 'cancer'
#epall.use(2)