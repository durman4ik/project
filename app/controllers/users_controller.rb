class UsersController < InheritedResources::Base
  before_filter :authenticate_user!

  def profile
    @schemes = Scheme.where(:user_id => current_user.id)
    @users = User.all
  end

  def destroy
    authorize! :edit, @user
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_menu_path
  end

  def admin_menu
    @users = User.all
    @schemes = Scheme.all
    render "users/administrator_menu"
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "Successfully updated User."
      redirect_to admin_menu_path
    else
      render :action => 'edit'
    end    
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @schemes = Scheme.where(:user_id => params[:id])
  end

  private

  def user_params
    if current_user.role == "admin"
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      params.require(:user).permit(:username, :role, :email, :avatar, :password, :password_confirmation)
    else
      render "403"
    end
  end

end