class ElementsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_action :set_element, only: [:edit, :show, :destroy, :update]

  def new
    authorize! :create, Element
    @element = Element.new
    @element.properties.build
  end

  def index
    authorize! :edit, Element
    @elements = Element.paginate(page: params[:page], per_page: 10)
  end

  def edit
    authorize! :edit, Element 
  end

  def create
    authorize! :create, Element
    @element = Element.new(element_params)
    if @element.save
      flash[:notice] = "Successfully created Element."
      redirect_to element_path(@element)
    else
      flash[:alert] = @element.errors
      render "new"
    end
  end

  def update
    authorize! :create, Element

    if @element.update(element_params)
      flash[:notice] = "Successfully updated Element."
      redirect_to element_path(@element)
    else
      flash[:alert] = @element.errors
      render "edit"
    end
  end

  def destroy
    authorize! :delete, Element

    if @element.destroy
      flash[:notice] = "Successfully deleted Element."
      redirect_to :back
    end
  end

private

  def set_element
    @element = Element.find(params[:id])
  end

  def element_params
    params.require(:element).permit(:title, :num_inputs, :image, properties_attributes: [:id, :element_id, :title, :value])
  end

end
