class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :ownerships, dependent: :destroy
  has_many :items, through: :ownerships, dependent: :destroy
  has_many :wants, dependent: :destroy
  has_many :want_items, through: :wants, class_name: 'Item', source: :item, dependent: :destroy
  has_many :haves, class_name: 'Have', dependent: :destroy
  has_many :have_items, through: :haves, class_name: 'Item', source: :item, dependent: :destroy
  
  def want(item)
    self.wants.find_or_create_by(item_id: item.id)
  end
  
  def unwant(item)
    want = self.wants.find_by(item_id: item.id)
    want.destroy if want
  end
  
  def want?(item)
    self.want_items.include?(item)
  end
  
  def have(item)
    self.haves.find_or_create_by(item_id: item.id)
  end
  
  def unhave(item)
    have = self.haves.find_by(item_id: item.id)
    have.destroy if have
  end
  
  def have?(item)
    self.have_items.include?(item)
  end
  
end