class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  before_create :set_level

  #Logic for making replies two level deeper
  def set_level
    return true if self.commentable_type == "Post"
    raise ActiveRecord::Rollback if self.commentable_type == "Comment" && !self.commentable.level.nil? && self.commentable.level > 2
    if self.commentable_type == "Comment" && self.commentable.level.nil?
      self.level = 1
    else
      self.level = self.commentable.level + 1
    end
  end
end
