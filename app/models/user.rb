class User < ActiveRecord::Base
  include Slugable

  has_many :posts 
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 3 }

  after_initialize :set_defaults

  def generate_slug
    self.slug = find_unused_slug :username
  end

  def admin?
    self.role && self.role.to_sym == :admin
  end

  def moderator?
    self.role && self.role.to_sym == :moderator
  end

  def set_defaults
    self.time_zone ||= Rails.application.config.time_zone
  end
end
