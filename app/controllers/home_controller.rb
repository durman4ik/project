class HomeController < InheritedResources::Base

	def index
    @schemes_all = Scheme.includes(:user, :ratings)
    @schemes = @schemes_all.paginate(:page => params[:page], :per_page => 6)
	end

end