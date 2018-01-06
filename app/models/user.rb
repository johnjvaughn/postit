class User < ActiveRecord::Base
  has_many :posts 
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  before_save :generate_slug

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 3 }

  include Slugable
  
  def generate_slug
    self.slug = slugify(self.username)
  end

  def admin?
    (self.role && self.role.to_sym == :admin) ? true : false
  end

  def moderator?
    (self.role && self.role.to_sym == :moderator)
  end
end
