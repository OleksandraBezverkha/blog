class CommentsController < ApplicationController

  def create
    @comment=current_user.comments.create(comment_params)
    @post = @comment.post
    @comments = Comment.where(post_id: @comment.post_id).page(params[:page]).per(3)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      @error_comment = @comment.errors.full_messages.first
      respond_to do |format|
        format.html { redirect_to post_path }
        format.js#{flash.now[:notice]="ololo"}
      end
    end
  end
  
  def destroy
    @comment=Comment.find(params[:id])
    @comment.destroy
    @post = @comment.post
    @comments = Comment.where(post_id: @comment.post_id).page(params[:page]).per(3)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
      end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end