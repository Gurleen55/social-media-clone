class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :recent, -> { order(created_at: :desc) }
end
