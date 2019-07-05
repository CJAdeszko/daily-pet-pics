class VotesController < ApplicationController
  before_action :authenticate_user!

  def up_vote
    update_vote(1)
    flash[:notice] = "Upvoted post."
  end


  def down_vote
    update_vote(-1)
    flash[:notice] = "Downvoted post."
  end

  private

  def update_vote(new_value)
    @post = Post.find(params[:post_id])
    @vote = @post.votes.where(user_id: current_user.id).first

    if @vote
      @vote.update_attribute(:value, new_value)
    else
      @vote = current_user.votes.create(value: new_value, post: @post)
    end

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end
end
