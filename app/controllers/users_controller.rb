class UsersController < ApplicationController
	before_filter :authenticate_user!

  def profile
  	@schemes = Scheme.where(:user_id => current_user.id)
  	@users = User.where(id: 1..10)
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
  	redirect_to "/users/profile"
  end

end
