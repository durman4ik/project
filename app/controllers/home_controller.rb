class HomeController < InheritedResources::Base

	def index
    @top_schemes = Scheme.includes(:user).order(:rating).reverse_order.limit(5)
		@schemes = Scheme.includes(:ratings, :user).paginate(:page => params[:page], :per_page => 6)
	end

end