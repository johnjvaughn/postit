class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user
    if @comment.save
      redirect_to post_path(@post), notice: "Your comment was added."
    else
      @post.reload
      render "posts/show"
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    respond_to do |format|
      format.html { 
        unless vote.valid?
          flash[:error] = "You can only vote on a comment once."
        end
        redirect_to :back
      }
      format.js {
        unless vote.valid? 
          render js: "alert('You can only vote on a comment once.')"
        end
      }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
