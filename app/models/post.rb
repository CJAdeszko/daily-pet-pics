class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: :true
  validates :image, presence: :true
  validates :user, presence: :true

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end


  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end


  def tag_list
    tags.map(&:name).join(', ')
  end


  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end


  def up_votes
    votes.where(value: 1).count
  end


  def down_votes
    votes.where(value: -1).count
  end


  def points
    votes.sum(:value)
  end
end
