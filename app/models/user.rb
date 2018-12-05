class User < ApplicationRecord
  mount_uploader :picture, PictureUploader
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessor :email, :password, :remember_me, :picture, :picture_cache, :remove_picture

  validates_integrity_of  :picture
  validates_processing_of :picture
  
  has_many :messages
  has_many :comments
end
