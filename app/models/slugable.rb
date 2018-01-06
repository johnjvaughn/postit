module Slugable 
  def slugify(text)
    text.to_s.downcase.gsub(/\s+/, '-').gsub(/[^\w\-]/, '').gsub(/\-+/, '-').gsub(/(^-)|(-$)/, '')
  end

  def to_param
    self.slug
  end
end