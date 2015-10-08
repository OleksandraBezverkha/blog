class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  default_scope ->{order('created_at DESC')}
  validates :content, presence: true, length: { maximum: 10000 ,minimum:1}
end
