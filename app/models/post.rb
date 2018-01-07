class Post < ActiveRecord::Base
  include Voteable
  include Slugable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :category_posts
  has_many :categories, through: :category_posts

  validates :title, presence: true, length: { minimum: 5 }
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  def generate_slug
    self.slug = find_unused_slug :title
  end
end