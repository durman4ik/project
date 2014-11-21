class ElementsController < InheritedResources::Base

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

private

  def element_params
    params.require(:element).permit(:title, :image, :num_inputs, :category)
  end

end
