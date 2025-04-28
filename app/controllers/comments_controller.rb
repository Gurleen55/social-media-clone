class CommentsController < ApplicationController
  before_action :set_post

  def new
    @comment = @post.comments.build
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
