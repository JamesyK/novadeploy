helpers do

  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def redirects_non_user
    if !current_user
      redirect '/articles' unless request.path == '/' || request.path == '/users' || request.path == '/users/new' || request.path == '/users/signin' || request.path == '/users/signin/test' || request.path == '/articles' || request.path =~ /\/articles\/\d+/
    end
  end

  def find_bookmark(article_id)
    Bookmark.where("user_id = ? AND article_id = ?", current_user.id, article_id)
  end

  def find_comment(article_id)
    Comment.where("user_id = ? AND article_id = ?", current_user.id, article_id)
  end

  def find_like(article_id)
    Like.where("user_id = ? AND article_id = ?", current_user.id, article_id)
  end

  def total_user_likes(user)
    total_likes = 0
    user.articles.each do |article|
      total_likes += article.likes.count
    end
    total_likes
  end

  def user_ranking(user)
    user_rank = 0
    user.articles.each do |article|
      user_rank += article.likes.count
    end
    if user_rank >= 0 && user_rank < 3
      return "Cadet Trainee"
    elsif user_rank >= 3 && user_rank < 5
      return "Space Cadet"
    elsif user_rank >= 5 && user_rank < 9
      return "Senior Cadet"
    elsif user_rank >= 9  && user_rank < 12
      return "Astronaut"
    elsif user_rank >= 12  && user_rank < 10000
      return "Commander"
    else 
      return "NASA HQ CEO"
    end
  end
  
  def list_bookmarks
    Article.joins(:bookmarks).where(bookmarks: { user_id: current_user.id })
  end

  def url_information
    OpenGraph.fetch(session[:article_url])
  end

end