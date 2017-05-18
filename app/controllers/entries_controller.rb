# route handlers dealing with the collection
get '/entries' do
  @entries = Entry.most_recent
  erb :'entries/index'
end

post '/entries' do
  @entry = Entry.new(params)
  @entry.assign_attributes(user_id: session[:id])

  if @entry.save
    if request.xhr?
      erb :"_post", :layout => false, :locals => {:entry => @entry}
    else
      redirect "/entries/#{@entry.id}"
    end
      @errors = @entry.errors.full_messages
      erb :'entries/new' 
  end

  # if @entry.save
  #   redirect "/entries/#{@entry.id}"
  # else
  #   @errors = @entry.errors.full_messages
  #   erb :'entries/new'
  # end
end

get '/entries/new' do
  erb :'entries/new'
end

get '/entries/:id' do
  @entry = find_and_ensure_entry(params[:id])
  erb :'entries/show'
end

put '/entries/:id' do
  @entry = find_and_ensure_entry(params[:id])
  @entry.assign_attributes(params[:entry])

  if @entry.save
    redirect "entries/#{@entry.id}"
  else
    @errors = @entry.errors.full_messages
    erb :'entries/edit'
  end
end

delete '/entries/:id' do
  @entry = find_and_ensure_entry(params[:id])
  @entry.destroy
  redirect '/entries'
end

get '/entries/:id/edit' do
  @entry = find_and_ensure_entry(params[:id])
  if @entry.user_id == session[:id]
    erb :'entries/edit'
  else
    erb :'404'
  end
end
