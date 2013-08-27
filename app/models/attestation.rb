class Attestation
  attr_accessor :requestPass, :requestId, :username

  def initialize

    @requestPass
    @requestId
  end
    
  def attestation  
    users = UserAttestation.find(:all, :conditions => {:user_id => @requestId} )
    user = users.first
    if user
      case @requestPass
      when user.password
        @username = user.user_id
      else
        return "not password"
      end
    else
      return "not exist user"
    end
  
  end
  
end