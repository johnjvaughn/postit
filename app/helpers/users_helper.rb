module UsersHelper
  def postsActive?
    params[:tab].nil?
  end

  def commentsActive?
    params[:tab] == "comments"
  end
end
