module Slugable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug
  end

  def slugify(text)
    text.to_s.downcase.gsub(/\s+/, '-').gsub(/[^\w\-]/, '').gsub(/\-+/, '-').gsub(/(^-)|(-$)/, '')
  end

  def find_unused_slug(slug_field)
    slug_base = slugify self[slug_field]
    trial_slug = slug_base
    i = 2
    this_id = self.id ? self.id : 0
    while self.class.where("id != ?", this_id).find_by(slug: trial_slug)
      trial_slug = slug_base + "-#{i}"
      i += 1
    end
    trial_slug
  end

  def to_param
    self.slug
  end
end