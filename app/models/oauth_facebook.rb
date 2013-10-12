class OauthFacebook < ActiveRecord::Base
  attr_accessible :code, :expires, :fuid, :fname, :token
  
  def self.create_with_omniauth(auth, params)

    access_token = auth[:credentials][:token]
    
    create! do |oauthfacebook|
      oauthfacebook.fname = auth['info']['name']
      oauthfacebook.expires = auth['credentials']['expires_at']
      oauthfacebook.fuid = auth['uid']
      oauthfacebook.token = access_token
  
    end
    
  end
  
  def self.get_access_token(auth, params)
    queri = [
      ['client_id',  ENV['FACEBOOK_APP_ID'] ],
      ['redirect_uri', 'http://localhost:3000/auth/facebook/get_facebook_token' ] ,
      ['client_secret', ENV['FACEBOOK_APP_SECRET'] ],
      ['code', params[:code] ]
    ]
    
    buf = []
    queri.each{|q|
      buf << q.join('=')
    }
    queri = buf.join('&')
    url = 'https://www.facebook.com/dialog/oauth?' + queri
    puts ' aaaaaaa'
    puts url
    
    f = open(url)
    p f
    
    #redirect_to "<a href='#{url}'>#{url}</a>"
    
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup

    where(:fuid => conditions).first
  end
  
  
  
end
