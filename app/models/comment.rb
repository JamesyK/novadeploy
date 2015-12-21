class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article, counter_cache: true

  validates :comment, presence: true
end