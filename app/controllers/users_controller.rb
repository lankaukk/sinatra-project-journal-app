class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect '/entries'
        else
            erb :'users/signup'
        end       
    end

    post '/signup' do 
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        else
            @user = User.new(params)
            @user.save
            session[:user_id] = @user.id
            redirect '/entries'
            # username: params[:username], email: [:email], password: params[:password]
        end
    end

    get '/login' do
        if logged_in?
            redirect '/entries'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/entries'
        else
            redirect '/signup'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

end