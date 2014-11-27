class RatingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @scheme = Scheme.find_by_id(params[:scheme_id])
    if (current_user.id == @scheme.user_id) && (current_user.role != "admin")
        redirect_to scheme_path(@scheme), :alert => "You cannot rate for your own photo"
    else
      @rating = Rating.new(rating_params)
      @rating.scheme_id = @scheme.id
      @rating.user_id = current_user.id
      if @rating.save!
        respond_to do |format|
            format.html { redirect_to scheme_path(@scheme), :notice => "Your rating has been saved" }
            format.js
        end
      end
    end
    authorize! :create, Rating
  end

  def update  
    @scheme = Scheme.find_by_id(params[:scheme_id])
    @rating = current_user.ratings.find_by_scheme_id(@scheme.id)
    if @rating.update(rating_params)
      respond_to do |format|
          format.html { redirect_to scheme_path(@scheme), :notice => "Your rating has been updated" }
          format.js
      end
    end
    authorize! :update, Rating
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end

end