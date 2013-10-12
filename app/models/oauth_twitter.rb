class OauthTwitter < ActiveRecord::Base
  attr_accessible :stoken, :tuid, :tname, :token
  
  def self.create_with_omniauth(auth)
    create! do |oauthtwitter|
      oauthtwitter.stoken = auth['credentials']['secret']
      oauthtwitter.tname = auth['info']['nickname']
      oauthtwitter.token = auth['credentials']['token']
      oauthtwitter.tuid = auth['uid']
    end
    
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup

    where(:tuid => conditions).first
  
  end
    
end
