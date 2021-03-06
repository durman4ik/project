module SchemeHelper

  def rating  
    if @rating = current_user.ratings.find_by_scheme_id(params[:id])
        @rating
    else
        current_user.ratings.new
    end
  end

  def current_user_rating
    if current_user
      @rating.value if @rating = current_user.ratings.find_by_scheme_id(params[:id])
    end
  end

  def user_can_voted?
    (current_user.ratings.find_by_scheme_id(params[:id]).nil? && current_user.id != @scheme.user_id) || if_admin? unless current_user.nil?
  end

end
