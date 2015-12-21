get '/users' do
  @users = User.all
  erb :'users/index'
end

get '/users/new' do
  erb :'users/new', :layout => :layout_landing
end

get '/users/signin' do
  erb :'users/signin', :layout => :layout_landing
end

get '/users/signout' do
  flash[:notice] = "Goodbye, #{current_user.username}"
  session.clear
  redirect '/articles'
end

get '/users/:id' do
  @user = User.find_by_id params[:id]
  if @user
    @total_likes = total_user_likes(@user)
    @user_rank = user_ranking(@user)
    @articles = @user.articles.order_by_newest
    @bookmarks = list_bookmarks
    erb :'users/show'
  else
    erb :'error'
  end
end

post '/users' do
  user = User.create(params[:user])
  if user.persisted?
    session[:user_id] = user.id
    flash[:notice] = "Welcome to Nova, #{user.username}"
    redirect '/articles'
  else
    flash[:notice] = "There were some issues with creating your account, please try again."
    redirect '/users/new'
  end
end

post '/users/signin' do
  user = User.find_by(email: params[:email]) if User.find_by(email: params[:email])
  if user && user.email && user.password == params[:password]
    session[:user_id] = user.id
    flash[:notice] = "Welcome back, #{user.username}!"
    redirect '/articles'
  else
    flash[:notice] = "Invalid email or password."
    redirect '/users/signin'
  end
end
