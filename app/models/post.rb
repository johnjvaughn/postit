class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :category_posts
  has_many :categories, through: :category_posts
  has_many :votes, as: :voteable

  before_save :generate_slug

  validates :title, presence: true, length: { minimum: 5 }
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  include Voteable
  include Slugable

  def generate_slug
    self.slug = self.title.gsub(' ', '-').downcase
  end
end