class PostsController < ApplicationController
   # before_action :signed_in_user
  def new
    @post=Post.new
  end
  def index
    @posts=Post.all
  end
  def show
    @post=Post.find(params[:id])
  end
  def create
    @post=current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path
    end
  end



  private

  def post_params
    params.require(:post).permit(:content, :title)
  end
end