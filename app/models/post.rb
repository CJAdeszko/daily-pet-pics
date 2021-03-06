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


  def self.search(search)
    if search
      tag = Tag.find_by(name: search)
      user = User.find_by(username: search)
      title = Post.where(["title LIKE ?", "%#{search}%"])
      if tag
        tag.posts
      elsif user
        user.posts
      elsif title
        title
      else
        Post.all
      end
    else
      Post.all
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

  def fix_exif_rotation(image)
    return image.variant(auto_orient: true).processed
  end
end
