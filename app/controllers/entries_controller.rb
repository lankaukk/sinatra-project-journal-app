class EntriesController < ApplicationController
    get '/entries' do
        if logged_in?
            @entries = current_user.entries
            # @user = User.find_by(email: params[:email])
            
            erb :'entries/entries'   
        else
            # If a user is not logged in, it will redirect to /login.
            redirect '/login'
        end
    end

    post '/entries' do 
        if logged_in?
            if params[:content] == "" || params[:title] == ""
                # raise error, hey you can't leave it blank
                redirect to '/entries'
            else
                @entry = Entry.create(title: params[:title], content: params[:content], user_id: @user.id)
                @entry.save
                redirect to "/entries/#{@entry.id}"
            end
        else 
            redirect '/login'
        end
    end

    get '/entries/:id' do 
        if logged_in?
            @entry = Entry.find_by(id: params[:id])
            erb :'entries/show'
        else 
            redirect '/login'
        end
    end

    get '/entries/:id/edit' do 
        if logged_in? 
            @entry = Entry.find_by(id: params[:id])
            
            if @entry && @entry.user_id == current_user.id
                erb :'entries/edit'
            else
                redirect '/entries'
            end
         else
                redirect '/login'
         end
    end

    patch '/entries/:id' do 
        if logged_in?
            if params[:content] == "" || params[:title] == ""
                redirect to "/entries/#{params[:id]}/edit"
            else
                @entry = Entry.find_by_id(params[:id])
                if @entry && @entry.user_id == current_user.id
                    # binding.pry
                    @entry.update(title: params[:title],content: params[:content])
                    redirect to "/entries/#{@entry.id}"
                else 
                    redirect '/entries/:id'
                end
            end
        end
    end

    # delete '/entries/:id' do
    #     @entry = Entry.find_by(username: params[:username])
    #     if logged_in?
    #         @entry = Entry.find_by(id: params[:id])
    #         if @entry && @entry.user_id == @user.id
    #             @entry.destroy
    #             @entry.delete
    #         end
    #         redirect '/entries'
    #     else
    #         redirect '/index'
    #     end
    # end

    delete '/entries/:id' do 
        @entry = Entry.find_by(id: params[:id])
        @entry.destroy
        @entry.delete
        redirect '/entries'
    end
end