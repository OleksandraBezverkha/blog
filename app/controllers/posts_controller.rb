class PostsController < ApplicationController
   # before_action :signed_in_user
  def new
    @post=Post.new
  end
  def index
    @posts=Post.all
  end
  def show
    # p params.inspect
    @post=Post.find(params[:id])
  end
  def create
    @post=current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  def destroy

    @post=Post.find(params[:id])
    if current_user == @post.user
        @post.destroy
    end
     redirect_to root_path
  end



  private

  def post_params
    params.require(:post).permit(:content, :title)
  end
end