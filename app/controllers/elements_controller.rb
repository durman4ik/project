class ElementsController < InheritedResources::Base

  before_action :set_element, only: [:edit, :show, :destroy, :update]

  def new
    authorize! :create, Element
    @element = Element.new
    @element.properties.new
  end

  def index
    authorize! :edit, Element
    @elements = Element.paginate(page: params[:page], per_page: 10)
    
  end

  def show
    @element = Element.find(params[:id])
  end

  def edit
    authorize! :edit, Element    
  end

  def create
    @element = Element.create(element_params)
    redirect_to element_path(@element)
  end

  def update
    binding.pry
    @element.update(element_params)
    
    redirect_to element_path(@element)
  end

  def destroy
    if can? :delete, Element
      if @element.destroy
        flash[:notice] = "Successfully deleted Element."
        redirect_to admin_menu_path
      end
    end
  end

private

  def set_element
    @element = Element.find(params[:id])
  end

  def element_params
    params.require(:element).permit!
  end

end
