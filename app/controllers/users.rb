enable :sessions

get '/login' do
  @user = User.new
  erb :'users/login'
end

post '/login' do
  @user = User.find_by(email: params[:user][:email])
  if @user.authenticate(params[:user][:email], params[:user][:password])
    session[:id] = @user.id
    redirect '/users/:id'
  else
    erb :'users/login'
  end
end

get '/users/:id' do
  erb :'users/login' unless session[:id]
  @user = User.find(params[:id])
  erb :'users/show'
end

get '/users/new' do
  @user = User.new
  erb :'users/login'
  #same kind of form
end

post '/users' do
  @user = User.new(params[:user])
  @user.password=(params[:user][:password])
  @user.save
  session[:id] = @user.id
  redirect '/users/:id'
end

