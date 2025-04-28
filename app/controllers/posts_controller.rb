class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_post, only: %i[edit update destroy show]
  before_action :authorize_user!, only: %i[edit update destroy]
  def index
    @posts = Post.includes(:user).recent.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      respond_to do |format|
        format.html { redirect_to posts_path, notice: "Post was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Post was successfully created." }
      end
    else
        render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.includes(:user, comments: :user).find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Post was successfully destroyed." }
    end
  end

  private
  def post_params
    params.expect(post: [ :body ])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless @post.user == current_user
      redirect_to posts_path, alert: "You are not authorized"
    end
  end
end
