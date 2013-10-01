class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :facebook_id, :twitter_id, :username
  
  # attr_accessible :title, :body
  
  def self.find_first_by_auth_conditions(conditions)
    buf = ''
    conditions.each{|key, value|
      buf = where(key => value).first
    }
    return buf
  end
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.username = auth['info']['nickname']
      user.password = 'pbmd_test_pass67'
      case auth['provider']
      when 'facebook'
        user.facebook_id = auth['uid']
        user.email = auth['info']['email']
      when 'twitter'
        user.twitter_id = auth['uid']
        user.email = 'pbmd_test@pbmd.tes.tsuku'
        user.password = 'pbmd_test_pass67'
      end
    end
    
  end
  
end
