class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :recent, -> { order(created_at: :desc) }
  scope :feed_for, ->(user) {
    where(user_id: user.following_ids + [ user.id ])
  }
end
