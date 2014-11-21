class SchemesController < InheritedResources::Base

	def index
		authorize! :read, @scheme
		@users = Users.all
		@schemes = Scheme.where(:user_id => current_user.id)
		@schemes.each { |scheme| }
	end

	def edit
		@scheme = Scheme.find(params[:id])
		authorize! :edit, @scheme
	end

	def new
		@scheme = Scheme.new
		@elements = Element.all		
		authorize! :create, @scheme
	end

	def create
		@scheme = Scheme.new(scheme_params)
		@scheme.user_id = current_user.id
		@scheme.save!
		redirect_to user_root_path
		authorize! :create, @scheme
	end

	def show
		@scheme = Scheme.find(params[:id])
		if current_user.nil?
			@schemes = Scheme.all
		else
			@schemes = Scheme.where(:user_id => current_user.id)
		end	
	end

	def destroy
		authorize! :destroy, @scheme
		if current_user.role == "admin"
			@scheme.destroy
      flash[:notice] = "Successfully deleted Scheme."
			render "users/administrator_menu"
		end
	end

	private

		def scheme_params
			params.require(:scheme).permit(:title, :description)
		end

end
