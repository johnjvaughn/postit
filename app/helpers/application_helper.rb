module ApplicationHelper
  def fix_url(url)
    return url if url.starts_with?("http://", "https://")
    return "http://" + url
  end

  def format_datetime(timestamp)
    if logged_in? && !current_user.time_zone.blank?
      timestamp = timestamp.in_time_zone(current_user.time_zone)
    end
    timestamp.strftime("%m/%d/%Y %l:%M%P %Z")
  end

  def pluralizer(arr, obj_name)
    str = "#{arr.length} #{obj_name}"
    str += arr.length == 1 ? "" : "s"
    str
  end
end
