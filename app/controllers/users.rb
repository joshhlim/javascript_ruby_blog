enable :sessions

get '/login' do
  @user = User.new
  erb :'users/login'
end

post '/login' do
  @user = User.find_by(email: params[:user][:email])
  if @user.authenticate(params[:user][:email], params[:user][:password])
    session[:id] = @user.id
    redirect "/"
  else
    erb :'users/login'
  end
end

get '/users/new' do
  erb :'users/new'
end

get '/users/:id' do
  erb :'users/login' unless session[:id]
  @user = User.find(params[:id])
  puts @user.inspect
  erb :'users/show'
end



post '/users' do
  @user = User.new(params[:user])
  @user.password=(params[:user][:password])
  @user.save
  session[:id] = @user.id

  if request.xhr?
    response = {name: @user.full_name, email: @user.email}
    content_type :json
    p response.to_json
  else
    redirect "/"
  end
end

get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :'users/login'
end

put '/users/:id' do
  @user = User.find(params[:id])
  @user.assign_attributes(params[:user])
  @user.password=(params[:user][:password])
  @user.save
  redirect "/"
end

get '/users/:id/entry' do
  @user = User.find(params[:id])
  erb :'users/login'
end

get '/logout' do
  session.delete(:id)
  redirect '/'
end
