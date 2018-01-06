class Category < ActiveRecord::Base
  has_many :category_posts
  has_many :posts, through: :category_posts

  before_save :generate_slug

  validates :name, presence: true

  include Slugable

  def generate_slug
    self.slug = self.name.gsub(' ', '-').downcase
  end
end