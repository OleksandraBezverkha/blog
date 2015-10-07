class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, length: { maximum: 10000 ,minimum:1}
end
