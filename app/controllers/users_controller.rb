class UsersController < ApplicationController
	before_filter :authenticate_user!

  def profile
  	@schemes = Scheme.where(:user_id => current_user.id)
  	@users = User.where(id: 1..10)
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy(:id)
  	redirect_to user_root_path
  end

  def edit

  end

end
