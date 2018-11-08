class Message < ApplicationRecord
  has_many :comments
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }
  validates :user, presence: true
end
