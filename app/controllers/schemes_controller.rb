class SchemesController < InheritedResources::Base
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@schemes = Scheme.where(:user_id => current_user.id)
		@schemes.each { |scheme| }
	end

	def create
		authorize! :create, @scheme
		@scheme.user_id = current_user.id
		@scheme.save!
		redirect_to user_root_path

	end

	def show
		@schemes = Scheme.where(:user_id => current_user.id)
		@schemes.each { |scheme| p scheme }
	end

	def scheme_params
		params.require(:scheme).permit(:title, :description)
	end
end
