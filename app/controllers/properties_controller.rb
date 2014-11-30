class PropertiesController < InheritedResources::Base
  before_filter :authenticate_user!

  def create
    @element = Element.find(params[:property][:element_id])
    @property.element_id = @element.id
    if @property.save
      flash[:notice] = "Property succsessfully created"
      redirect_to element_path(@element)
    else
      flash[:alert] = @property.errors
      redirect_to element_path(@element)
    end    
  end

  def destroy
    @property = Property.find(params[:id])
    if @property.can_destoy_property(@property.element)
      if @property.destroy
        flash[:notice] = "Свойство успешно удалено"
        redirect_to element_path(@property.element)
      end
    else
      flash[:alert] = "Нельзя удалить свойство"
      redirect_to element_path(@property.element)
    end
  end

  private

  def property_params
    params.require(:property).permit(:title, :value)
  end

end
