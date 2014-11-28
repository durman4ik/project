class PropertiesController < ApplicationController

  def create
    @element = Element.find(params[:property][:element_id])
    @property = @element.properties.new(property_params)
    @property.element_id = @element.id
    if @property.save
      flash[:notice] = "Property succsessfully created"
      redirect_to element_path(@element)
    else
      flash[:alert] = @property.errors
      render "elements/show"
    end    
  end

  private

  def property_params
    params.require(:property).permit(:id, :title, :value)
  end

end
