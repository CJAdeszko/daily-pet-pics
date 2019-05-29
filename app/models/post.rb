class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: :true
  validates :image, presence: :true
  validates :user, presence: :true
end