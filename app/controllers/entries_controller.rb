# route handlers dealing with the collection
get '/entries' do
  @entries = Entry.most_recent
  erb :'entries/index'
end

post '/entries' do
  @entry = Entry.new(params[:entry])
  @entry.assign_attributes(user_id: session[:id])
  @entry.save

  if request.xhr?
    erb :'entries/_post', layout: false, locals: {entry: @entry}
  else
    redirect "/entries/#{@entry.id}"
  end
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
  @entry.save
 puts params
  if request.xhr?
    erb :'entries/show', layout: false, locals: {entry: @entry}
  else
    redirect "entries/#{@entry.id}"
    # @errors = @entry.errors.full_messages
    # erb :'entries/edit'
  end
end

delete '/entries/:id' do
  @entry = find_and_ensure_entry(params[:id])
  @entry.destroy

  if request.xhr?
    "Entry Removed Will Be Removed"
  else
    redirect '/entries'
  end
end

get '/entries/:id/edit' do
  @entry = find_and_ensure_entry(params[:id])
  if request.xhr?
    erb :'entries/edit', layout: false, locals: {entry: @entry}
  else
    erb :'entries/edit'
  end
end
