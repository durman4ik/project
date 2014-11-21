class HomeController < InheritedResources::Base
	def index
		@schemes = Scheme.all
	end
end
