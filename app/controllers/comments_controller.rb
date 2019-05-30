class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end


  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment saved successfully."
      redirect_to [@commentable]
    else
      flash[:alert] = "Comment failed to save."
      redirect_to [@commentable]
    end
  end


  def edit
    @comment = Comment.find(params[:id])
  end


  def update
    @comment = Comment.find(params[:id])
    @comment.assign_attributes(comment_params)
    @post = Post.find_by_id(@comment.commentable.id)
    
    if @comment.save
      flash[:notice] = "Comment updated successfully."
      redirect_to @post
    else
      flash.now[:alert] = "There was a problem saving your comment. Please try again."
      render :edit
    end
  end


  def destroy
    @comment = @commentable.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@commentable]
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to [@commentable]
    end
  end


  private
  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end


  def comment_params
    params.require(:comment).permit(:body)
  end
end
