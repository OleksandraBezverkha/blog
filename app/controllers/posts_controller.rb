class PostsController < ApplicationController
   before_action :signed_in_user, only: [:create, :destroy]
  def new
    @post=Post.new
  end
  def create
    @post=current_user.posts.build(post_params)
    if @post.save
      redirect_to new_posts_path
    end
  end












  private

  def post_params
    params.require(:post).permit(:content, :title)
  end
end