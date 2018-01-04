module ApplicationHelper
  def fix_url(url)
    return url if url.starts_with?("http://", "https://")
    return "http://" + url
  end

  def format_datetime(timestamp)
    time = timestamp.getlocal
    if (time.zone.length > 3)
      timeZone = time.zone.split.map { |word| word[0] }.join
    else
      timeZone = time.zone
    end
    time.strftime("%m/%d/%Y %l:%M%P #{timeZone}")
  end
end
