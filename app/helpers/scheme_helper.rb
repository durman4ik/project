module SchemeHelper

  def rating_ballot  
    if @rating = current_user.ratings.find_by_scheme_id(params[:id])
        @rating
    else
        current_user.ratings.new
    end
  end

  def current_user_rating
    if @rating = current_user.ratings.find_by_scheme_id(params[:id])
        @rating.value
    else
        "N/A"
    end
  end

  def user_can_voted?
    current_user.ratings.find_by_scheme_id(params[:id]).nil? || if_admin? unless current_user.nil?
  end

end
