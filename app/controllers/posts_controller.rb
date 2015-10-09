class PostsController < ApplicationController
   # before_action :signed_in_user
  def new
    @post=Post.new
  end
  def index
    @tags = Post.tag_counts_on(:tags).most_used(15)
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).page(params[:page]).per(3)
    else
      @posts=Post.all.page(params[:page]).per(3)
    end
    end
  def show
     # p params.inspect
    @post=Post.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(3)
    end
  def create
    @post=current_user.posts.create(post_params)
    if @post.save
      redirect_to root_path
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
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
    params.require(:post).permit(:title,:content, :tag_list)
  end
end