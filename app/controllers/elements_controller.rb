class ElementsController < InheritedResources::Base

  before_action :set_element, only: [:edit, :show, :destroy]

  def new
    authorize! :create, Element
    @element = Element.new
  end

  def show
    @elements = Element.where(params[:element])
  end

  def edit
    authorize! :edit, Element    
  end

  def idex

  end

  def destroy
    if can? :delete, Element
      @element.destroy
      flash[:notice] = "Successfully deleted Element."
      render "users/administrator_menu"
    end
  end

private

  def set_element
    @element = Element.find(params[:id])
  end

  def element_params
    params.require(:element).permit(:title, :image, :num_inputs, :category)
  end

end
