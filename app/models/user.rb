class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :provider, :uid, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  attr_accessor :login
  attr_accessible :login
  
  #use omniauth
  validates :provider, presence: :true
  validates :uid, presence: :false
  validates :username, presence: :true
  
  validates_uniqueness_of :uid, scope: :provider
  
  def self.create_with_omniauth(auth)
    create! do |user|
      puts 'aaaaaaaaaa'
      p auth
      
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      buf_email = auth['info']['name'] + '@examples.jjj'
      user.email = buf_email
      user.username = auth['info']['nickname']
      user.password = auth['info']['name']
    end
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
end
