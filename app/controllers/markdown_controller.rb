class MarkdownController < InheritedResources::Base
  def preview    
    @text = params[:data] 
    render layout: false   
  end
end
