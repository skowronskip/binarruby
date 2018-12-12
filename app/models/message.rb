class Message < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user

  has_one_attached :photo

  paginates_per 3

  validates :content, presence: true, length: { maximum: 140 }
  validates :user, presence: true
end
