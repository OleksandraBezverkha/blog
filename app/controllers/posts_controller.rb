class PostsController < ApplicationController
   # before_action :signed_in_user
  def new
    @post=Post.new
  end
  def index
    @search = Post.search(params[:q])
    # @posts = @search.result(distinct: true).page(params[:page]).per(3)
    @tags = Post.tag_counts_on(:tags).most_used(10)
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).page(params[:page]).per(10)
    elsif !params[:q].nil?
      @posts = Post.tagged_with(params[:q][:tags_name_cont],any: true).search('').result.page(params[:page]).per(3)
      # @posts=@search.result.includes(:tags).page(params[:page]).per(3)
    else
      @posts=Post.all.page(params[:page]).per(10)
    end

    end
  def show
     # p params.inspect
    @post=Post.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(10)
    end
  def create
    @post=current_user.posts.create(post_params)
    if @post.save
      # Event.create
      # @event.name=params[:action]
      current_user.events.create(name: "#{t(:create)}", post_title: @post.title, post_id: @post.id)#, post_title: @post.title)
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
     current_user.events.create(name: "#{t(:destroy)}", post_title: @post.title, post_id: @post.id)#, post_title: @post.title)
    end
     redirect_to root_path
  end



  private

  def post_params
    params.require(:post).permit(:title,:content,:tag_list,:user_id)
  end
end