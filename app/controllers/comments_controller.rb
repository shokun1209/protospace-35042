class CommentsController < ApplicationController
  
  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to "/prototypes/#{@comment.prototype.id}"
    else
      @prototype = Prototype.find(params[:prototype_id])
      # @prototype = @comment.prototype      この記述でも動いた 同じような事が書かれている？
      @comments = @prototype.comments.includes(:user)
      render  "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
