class Auth < Sinatra::Base
  post('/auth/unauthenticated') do
    p "----------------ROUTE ACCESS--------------------"
    session[:return_to] = env['warden.options'][:message] || "You must log in"

    redirect '/auth/login'
  end
end



use Warden::Manager do |config|
  config.serialize_into_session{ |user| user.id }
  config.serialize_from_session{ |id| User.get(id)}

  config.scope_defaults :default,
  strategies: [:password],
  action: 'auth/unauthenticated'
  config.failure_app = Auth
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
    p params['user']['username']
    user = User.where(:username => params['user']['username']).first

    if user.nil?
      throw(:warden, :message => "The username you entered does not exist.")
    elsif user.authenticate(params['user']['password'])
      success!(user)
    else
      throw(:warden, :message => "The username and password combination")
    end
  end
end
