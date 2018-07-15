class Have < Ownership
  belongs_to :user
  belongs_to :item
  
  def self.ranking
    self.group(:item_id).order('count_item_id DESC').limit(10).count(:item_id)
  end
end
