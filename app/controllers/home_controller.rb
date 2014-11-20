class HomeController < InheritedResources::Base
	def index
		@schemes = Scheme.all
		@schemes.each { |scheme| p scheme }
	end
end
