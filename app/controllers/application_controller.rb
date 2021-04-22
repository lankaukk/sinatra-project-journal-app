require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret_journal"
  end

  get "/" do
    erb :index
  end

  helpers do  

    def logged_in?  
      !!current_user  
    end

    def current_user    #if sess-id exists- find user & set @user
      @user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end            
  end

  

end
