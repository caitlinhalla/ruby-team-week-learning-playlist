enable :sessions
register Sinatra::Flash
set :session_secret, "supersecret"

use Warden::Manager do |config|
  config.serialize_into_session do |user|
    user.id
  end
  config.serialize_from_session do |id|
    User.find(id)
  end

  config.scope_defaults :default,
  strategies: [:password],
  action: 'auth/unauthenticated'
  config.failure_app = Sinatra::Application
end

Warden::Manager.before_failure do |env, opts|
  env['REQUEST_METHOD'] = 'POST'

  env.each do |key, value|
    env[key]['_method'] = 'post' if key == 'rack.request.form_hash'
  end
end

Warden::Strategies.add(:password) do
  def valid?
    params['user'] && params['user']['username'] && params['user']['password']
  end

  def authenticate!
    user = User.where(:username => params['user']['username']).first

    if user.nil?
      throw(:warden, :message => "The username you entered does not exist.")
    elsif user.authenticate(params['user']['password'])
      success!(user)
    else
      throw(:warden, :message => "The username and password combination you entered is invalid.")
    end
  end
end
