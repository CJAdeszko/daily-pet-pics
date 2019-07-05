class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]
  devise :omniauthable, omniauth_providers: [:facebook]

  attr_writer :login

  validates :email, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  validates_format_of :email, :with => Devise.email_regexp
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  validates :password, length: { minimum: 6 }
  validates :password, presence: true


  def login
    @login || self.username || self.email
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
    end
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end


  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end


  def favorite_tags
    post = favorites.map { |fav| Post.find_by(id: fav.post_id) }
    favorite_tags = post.map(&:tag_list).join(',').split(',')
  end
end
