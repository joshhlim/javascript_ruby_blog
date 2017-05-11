enable :sessions

get '/users' do
  @errors = []
  erb :'/users/index'
end

get '/users/login' do
  erb :'/users/login'
end

#show
get '/users/:id' do
  @user = User.find_by(id: params[:id])
  erb :'/users/show'
end

post '/users/login' do
  if User.authenticate(params[:email], params[:password])
    user = User.find_by(email: params[:email])
    session['user_id'] = user.id
    redirect to "/users/#{user.id}"
  else
    redirect to '/users/login'
  end
end

#Create
post '/users' do
  user = User.create(params[:user])
  if user.valid?
    session['user_id'] = @user.id
    redirect to "/users/#{user.id}"
  else
    @errors = user.errors.full_messages
    erb :'/users/index'
  end
end

delete '/users' do
  session.delete('user_id')
  redirect to '/users'
end
