class CommentsController < ApplicationController
  before_action :find_commentable
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end


  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment saved successfully."
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Comment failed to save."
      redirect_back(fallback_location: root_path)
    end
  end


  def edit
    @comment = Comment.find(params[:id])
  end


  def update
    @comment = Comment.find(params[:id])
    @comment.assign_attributes(comment_params)

    if @comment.commentable_type == 'Post'
      @post = Post.find_by_id(@comment.commentable_id)
    else
      parent_comment = Comment.find_by_id(@comment.commentable_id)
      @post = Post.find_by_id(parent_comment.commentable_id)
    end

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
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_back(fallback_location: root_path)
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

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user
      flash[:alert] = "You do not have permission to do that."
      redirect_to root_path
    end
  end
end
