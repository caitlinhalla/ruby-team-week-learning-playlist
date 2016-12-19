require('../lib/user')

class App < Sinatra::Base
  enable :sessions
  # register Sinatra::Flash

  use Warden::Manager do |config|
    config.serialize_into_session{ |user| user.id }

  end

end
