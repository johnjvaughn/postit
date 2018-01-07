class Category < ActiveRecord::Base
  include Slugable

  has_many :category_posts
  has_many :posts, through: :category_posts

  validates :name, presence: true

  slugable_column :name
end