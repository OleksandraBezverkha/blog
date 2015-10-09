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
 # attr_accessible :content, :name, :tag_list
  acts_as_taggable
  paginates_per 5
  belongs_to :user
  has_many :comments,dependent: :destroy
  default_scope ->{order('created_at DESC')}
  validates :user_id, presence: true
  validates :title, presence: true,length: { maximum:150 ,mimimum:1}
  validates :content, presence: true, length: { maximum: 10000 ,minimum:1}
  # has_many :taggings
  # has_many :tags, through: :taggings

  # def self.tagged_with(name)
  #   Tag.find_by_name!(name).articles
  # end
  #
  # def self.tag_counts
  #   Tag.select("tags.*, count(taggings.tag_id) as count").
  #       joins(:taggings).group("taggings.tag_id")
  # end
  #
  # def tag_list
  #   tags.map(&:name).join(", ")
  # end
  #
  # def tag_list=(names)
  #   self.tags = names.split(",").map do |n|
  #     Tag.where(name: n.strip).first_or_create!
  #   end
  # end
end
