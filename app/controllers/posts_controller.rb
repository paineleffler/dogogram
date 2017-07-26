class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Your new post couldn't be created! Check the form!"
      render :new
    end
  end

  def show
    set_post
  end

  def edit
    set_post
    owned_post
  end

  def update
    set_post
    owned_post
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to(post_path(@post))
    else
      flash.now[:alert] = "Update failed. Check the form!"
      render :edit
    end
  end

  def destroy
    set_post
    owned_post
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    unless current_user == @post.user
      redirect_to root_path
    end
  end

end
