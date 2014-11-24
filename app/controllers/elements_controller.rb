class ElementsController < InheritedResources::Base

  def new
    authorize! :create, Element
    @element = Element.new
  end

  def show
    @elements = Element.where(params[:element])
    @element = Element.find(params[:id])
  end

  def edit
    authorize! :edit, Element    
  end

  def idex

  end

  def destroy
    @element = Element.find(params[:id])
    if can? :delete, Element
      @element.destroy
      flash[:notice] = "Successfully deleted Element."
      render "users/administrator_menu"
    end
  end

private

  def element_params
    params.require(:element).permit(:title, :image, :num_inputs, :category)
  end

end
