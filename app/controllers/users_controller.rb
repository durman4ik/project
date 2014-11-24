class UsersController < InheritedResources::Base
  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def profile
    @users = User.all
  end

  def destroy
    authorize! :manage, :all
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to admin_menu_path
    end
  end

  def admin_menu
    authorize! :manage, :all
    @users = User.all
    @schemes = Scheme.all
    @elements = Element.all
    render "users/administrator_menu"
  end

  def update
    authorize! :manage, :all
    if @user.update(user_params)
      sign_in(@user == current_user ? @user : current_user, :bypass => true)
      flash[:notice] = "Successfully updated User."
      redirect_to admin_menu_path
    else
      render :action => 'edit'
    end    
  end

  def edit
    authorize! :manage, :all
  end

  def show
    @schemes = Scheme.where(:user_id => params[:id]).paginate(:page => params[:page], :per_page => 9)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      if current_user.role == "admin"
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
        params.require(:user).permit(:username, :role, :email, :avatar, :password, :password_confirmation, :theme)
      else
        params.require(:user).permit(:username, :email, :avatar, :password, :password_confirmation, :theme)
      end
    end

end