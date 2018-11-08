class Comment < ApplicationRecord
  belongs_to :message
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }
  validates :user, presence: true
end
