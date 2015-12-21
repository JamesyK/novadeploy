get '/articles' do
  @created_order = Article.order_by_newest
  @likes_order = Article.order_by_likes
  erb :'articles/index'
end

get '/articles/new' do
  erb :'articles/new'
end

get '/articles/edit' do
  @url = url_information
  @url_backup = session[:article_url]
  erb :'articles/edit'
end

get '/articles/:id' do
  @article = Article.find_by_id params[:id]
  if @article
    erb :'articles/show'
  else
    erb :'error'
  end
end

post '/articles' do
  session[:article_url] = params[:url]
  redirect '/articles/edit'
end

post '/articles/edit' do
  article = current_user.articles.create(params[:article])
  if article.persisted?
    redirect "/articles/#{article.id}"
    session[:article_url]
  else
    flash[:notice] = "There were some issues with your article submission, please try again."
    redirect '/articles/edit'
  end
end

post "/articles/:article_id/likes" do
  @article = Article.find params[:article_id]
  @like = @article.likes.new
  @like.user = current_user
  if @like.save
    redirect back
  else
    flash[:notice] = "Could not like this article."
    redirect back
  end
end

post '/articles/:article_id/comments' do
  @article = Article.find params[:article_id]
  @comment = @article.comments.new comment: params[:comment]
  @comment.user = current_user
  if @comment.save
    redirect back
  else
    flash[:notice] = "Your comment was not submitted, please try again."
    redirect back
  end
end

post '/articles/:article_id/bookmarks' do
  @article = Article.find params[:article_id]
  @bookmark = @article.bookmarks.new
  @bookmark.user = current_user
  if @bookmark.save
    redirect back
  else
    flash[:notice] = "Could not bookmark this article."
    redirect back
  end
end

post '/articles/:article_id/bookmarks/delete' do
  @article = Article.find params[:article_id]
  @article = @article.id
  @bookmark = find_bookmark(@article)
  @bookmark[0].destroy!
  redirect back
end

post '/articles/:article_id/likes/delete' do
  @article = Article.find params[:article_id]
  @article = @article.id
  @like = find_like(@article)
  @like[0].destroy!
  redirect back
end

post '/articles/:article_id/comments/:comment_id/delete' do
  @article = Article.find params[:article_id]
  @comment = @article.comments.find params[:comment_id]
  @comment.destroy!
  redirect back
end
