class HomeController < ApplicationController
	def index
		@schemes = Scheme.all
		@schemes.each { |scheme| p scheme }
	end
end
