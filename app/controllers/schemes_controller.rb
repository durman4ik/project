class SchemesController < InheritedResources::Base

	before_filter :set_params_scheme, only: [:edit, :show, :destroy, :update]
	before_action :count_average_rating, only: [:show]

	def edit
		authorize! :edit, @scheme
	end

	def new
		@scheme = Scheme.new
		@elements = Element.all		
		authorize! :create, @scheme
	end

	def create
		authorize! :create, @scheme
		@scheme = Scheme.new(scheme_params)
		@scheme.user_id = current_user.id
		if @scheme.save
			redirect_to new_scheme_construction_path(@scheme)
			flash[:notice] = "Схема #{@scheme.title} успешно создана"
		else 
			flash[:alert] = "@scheme.error"
			render :back
		end	
	end

	def show
			@schemes = Scheme.includes(:ratings, :user)
	end

	def update
		@scheme.update(scheme_params)
		redirect_to new_scheme_construction_path(@scheme)

		unless params[:published].nil?
			@scheme.published = true
			@scheme.save

			redirect_to scheme_path(@scheme)
		end
	end

	def destroy
		authorize! :destroy, @scheme
		if @scheme.destroy
    	flash[:notice] = "Successfully deleted Scheme."
			redirect_to :back
		else
			flash[:alert] = @scheme.errors
		end
	end

	def search
			@schemes = Scheme.where(published: true).search(params[:search], :sql => {:include => [:user, :ratings]},
                             										:ranker => :bm25,
                             										:match_mode => :any,
                             										:page => params[:page],
																								:per_page => 10)
	end

	private

		def count_average_rating
			@scheme.average_rating
		end

		def set_params_scheme
			@scheme = Scheme.find(params[:id])
		end

		def scheme_params
			params.require(:scheme).permit(:title, :description, :short_description, :rating, :published, :image)
		end

end
