class Item < ApplicationRecord
  validates :code, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum:255 }
  
  has_many :ownerships, dependent: :destroy
  has_many :users, through: :ownerships, dependent: :destroy
  has_many :wants, dependent: :destroy
  has_many :wants_users, through: :wants, class_name: 'User', source: :user, dependent: :destroy
  has_many :haves, class_name: 'Have', dependent: :destroy
  has_many :have_users, through: :haves, class_name: 'User', source: :user, dependent: :destroy
end 
