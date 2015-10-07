# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  paginates_per 5
  belongs_to :user
  has_many :comments,dependent: :destroy
  default_scope ->{order('created_at DESC')}
  validates :user_id, presence: true
  validates :title, presence: true,length: { maximum:150 ,mimimum:1}
  validates :content, presence: true, length: { maximum: 10000 ,minimum:1}
end
