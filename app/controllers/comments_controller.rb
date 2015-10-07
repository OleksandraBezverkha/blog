class CommentsController < ApplicationController
  def new
    @comment=Comment.new
  end
  def index
     # @comments = Comment.all

  end
  def show
    # p params.inspect
    @comment=Comment.find(params[:id])
  end
  def create
    @comment=current_user.comments.create(comment_params)
    @post=@comment.post
    if @post.save
      respond_to do |format|
     # format.html { redirect_to root_path }
        format.js
    end
      else
        flash[:notice] = 'error'
        respond_to do |format|
          format.html { redirect_to :back }
          format.js
        end

    end
  end
  def destroy
    @comment=Comment.find(params[:id])
    @comment.destroy
    @post=@comment.post
    respond_to do |format|
      # format.html { redirect_to root_path }
      format.js
      end
  end



  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end