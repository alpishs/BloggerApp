class Post < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  belongs_to :user, optional: true
  has_many :likes, dependent: :destroy

  validates :title, :post_text, presence: true
end
