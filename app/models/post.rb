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
  belongs_to :user
  default_scope ->{order('created_at DESC')}
  validates :user_id, presence: true
  validates :title, presence: true,length: { maximum:150 ,mimimum:1}
  validates :content, presence: true, length: { maximum: 10000 ,minimum:1}
end
