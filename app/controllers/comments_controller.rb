class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :verify_user, only: [:edit, :update, :destroy]

  def create
    @user = current_user
    @comment = Comment.new(post_params)
    @comment.gossip_id = params[:gossip_id]
    @comment.user_id = @user.id
    if @comment.save
      flash[:notice] = "Your comment has been saved!"
      redirect_to gossip_path(params[:gossip_id])
    else
      puts @comment.errors.messages
      puts "Damn son! Your comment hasn't been saved for some reason 🤔"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @gossip = Gossip.find(params[:gossip_id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(post_params)
      flash[:notice] = "Your comment has been updated!"
      redirect_to gossip_path(params[:gossip_id])
    else
      flash.now[:alert] = "We cannot update this comment for the following reason(s):"
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:alert] = "Your comment has been deleted."
      redirect_to gossip_path(params[:gossip_id]) 
    else 
      flash.now[:alert] = "We cannot delete this comment the following reason(s):"
      render :edit
    end
  end

  private
  def post_params
    post_params = params.require(:comment).permit(:content)
  end

  def verify_user
    @comment = Comment.find(params[:id])
    unless current_user && (@comment.user_id == current_user.id)
      flash[:alert] = "Sorry bro! You can't just edit stuff that's not yours to begin with 😁"
      redirect_to gossip_project_home_path 
    end
  end

end
