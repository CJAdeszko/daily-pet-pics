class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved successfully."
      redirect_to [@post]
    else
      flash[:alert] = "Comment failed to save."
      redirect_to [@post]
    end
  end


  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end


  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.assign_attributes(comment_params)

    if @comment.save
      flash[:notice] = "Comment updated successfully."
      redirect_to @post
    else
      flash.now[:alert] = "There was a problem saving your comment. Please try again."
      render :edit
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@post]
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to [@post]
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
