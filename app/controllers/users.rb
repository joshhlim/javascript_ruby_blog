get '/users' do

end

get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  @user = User.find_by(username: params[:user][:username])
  if @user && @user.authenticate(params[:user][:password])
    session[:id] = @user.id
    redirect "/users/#{@user.id}/profile"
  else
    @errors = ["Login failed"]
    erb :'users/login'
  end
end

get '/users/new' do
  erb :'users/new'
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:id] = @user.id
    redirect "/users/#{@user.id}/profile"
  else
    @errors = @user.errors.full_messages
    puts @errors
    erb :'users/new'
  end
end

get '/users/:id' do

end

get '/users/:id/edit' do

end

put '/users/:id' do

end

delete '/users/:id' do

end



get '/users/:id/profile' do
  @user = User.find(params[:id])
  @entries = @user.entries
  erb :'users/profile', :layout => false
end


