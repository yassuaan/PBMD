require 'omniauth-twitter'

Rails.application.config.middleware.use OmniAuth::Builder do

  #provider :twitter,  '21PoU0HOkqsXqD7GEjuQ', 'bdBzM729Tk024OGhI8GGmiQkaQTyjbaaQTqZ07R9kj0'
  provider :twitter,  ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']

  provider :facebook, '624774550878660', '9475b18cbfbb0b18e9825e15cfa28861'

end
#  provider :twitter,
#    Settings.OmniAuth.twitter.consumer_key,
#    Settings.OmniAuth.twitter.consumer_secret
#  end

#$end