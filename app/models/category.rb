class Category < ActiveRecord::Base
  include Slugable

  has_many :category_posts
  has_many :posts, through: :category_posts

  validates :name, presence: true

  def generate_slug
    self.slug = find_unused_slug :name
  end
end