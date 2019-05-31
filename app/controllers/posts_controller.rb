class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end
  end


  def show
  end


  def new
    @post = Post.new
  end


  def edit
  end


  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post saved successfully."
      redirect_to @post
    else
      flash.now[:alert] = "There was a problem saving your post. Please try again."
      render :new
    end
  end


  def update
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post updated successfully."
      redirect_to @post
    else
      flash.now[:alert] = "There was a problem saving your post. Please try again."
      render :edit
    end
  end


  def destroy
    if @post.destroy
      flash[:notice] = "Post deleted successfully."
      redirect_to action: "index"
    else
      flash.now[:alert] = "There was a problem deleting your post. Please try again."
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :image, :tag_list, :tag, { tag_ids: [] }, :tag_ids )
    end
end
