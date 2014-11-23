class HomeController < InheritedResources::Base

	def index
    @top_schemes = Scheme.all
		@schemes = Scheme.all.paginate(:page => params[:page], :per_page => 6)
	end

end