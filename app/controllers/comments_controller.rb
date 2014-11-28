class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @scheme = Scheme.find(params[:scheme_id])
    @comment = @scheme.comments.new(comments_params)
    @comment.user_id = current_user.id
    @comment.scheme_id = @scheme.id
    if @comment.save
      flash[:notice] = "Comment succsessfully created"
      redirect_to :back
    end
  end

  def destroy
    @scheme = Scheme.find(params[:scheme_id])
    @comment = @scheme.comments.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end

end
