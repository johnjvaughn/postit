module Slugable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug!
    class_attribute :slug_column
  end

  def slugify(text)
    text.to_s.downcase.gsub(/\s+/, '-').gsub(/[^\w\-]/, '').gsub(/\-+/, '-').gsub(/(^-)|(-$)/, '')
  end

  def generate_slug!
    slug_base = slugify self[self.class.slug_column]
    trial_slug = slug_base
    i = 2
    this_id = self.id ? self.id : 0
    while self.class.where("id != ?", this_id).find_by(slug: trial_slug)
      trial_slug = slug_base + "-#{i}"
      i += 1
    end
    self.slug = trial_slug
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def slugable_column(col_name)
      self.slug_column = col_name
    end
  end
end