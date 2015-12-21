class User < ActiveRecord::Base
  has_many :articles
  has_many :bookmarks
  has_many :comments
  has_many :likes

  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    message: "Please enter a valid email address." }, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}

  def hasnt_liked?(article)
    Like.where("user_id = ? AND article_id = ?", self.id, article.id).empty?
  end

  def hasnt_bookmarked?(article)
    Bookmark.where("user_id = ? AND article_id = ?", self.id, article.id).empty?
  end

  def hasnt_commented?(article)
    Comment.where("user_id = ? AND article_id = ?", self.id, article.id).empty?
  end
  
  def gravitar
    hash = Digest::MD5.hexdigest(email)
    image_src = "http://www.gravatar.com/avatar/#{hash}?d=retro"
  end

end