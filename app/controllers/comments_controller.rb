class CommentsController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user     # ← make sure you have this line!

    if @comment.save
      redirect_to @post, notice: "Comment posted!"
    else
      render :new
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
