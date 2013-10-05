require 'omniauth-twitter'

Rails.application.config.middleware.use OmniAuth::Builder do

  #provider :twitter,  '21PoU0HOkqsXqD7GEjuQ', 'bdBzM729Tk024OGhI8GGmiQkaQTyjbaaQTqZ07R9kj0'
  provider :twitter,  ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']

  provider :facebook, ENV['APP_FACEBOOK_ID'], ENV['APP_FACEBOOK_SECRET'], scope: 'email, publish_stream'

end
#  provider :twitter,
#    Settings.OmniAuth.twitter.consumer_key,
#    Settings.OmniAuth.twitter.consumer_secret
#  end

#$end