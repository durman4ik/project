class ConstructionsController < InheritedResources::Base

  def construction_params
    params.require(:construction).permit(:scheme_id, :element_id, :cordx, :cordy)
  end
end
