class ConstructionsController < InheritedResources::Base

  def new
    @construction = Construction.new
    @elements = Element.all
    @scheme = Scheme.find(params[:scheme_id])
  end

  def foo
    
    if params[:query] == 'load_properties'
      scheme_params = JSON.parse (params[:data])

      @element = Element.find(scheme_params["element_id"])

      unless @element.nil?
        @properties = []
        
          @element.properties.each do |property| 
            a={}
            a[:name] = property.title
            a[:value] = property.value
            a[:id] = property.id
            @properties << a
          end

          render :json => { :answer => 'забирай свойства элемента' ,
                          :data=>{:id=> @element.id, :name => @element.title, :connections=> @element.num_inputs,
                                  :properties => @properties } }

      end
    end

    if params[:query] == 'load_scheme'

      #scheme_params = JSON.parse (params[:data])
      @scheme = Scheme.find(47)

      @objects = []

      @scheme.constructions.each do |construction|
        
        @elem = {}

        construction.parametrs.each do |parametr|
          @elem[parametr.name] = parametr.value
        end

        obj = {}
        obj[:id] = construction.element_id
        obj[:type] = construction.tips
        obj[:obj] = @elem
        @objects << obj
      end

      render :json => { :answer => 'держи массив обьектов', :data=>@objects }

    end

    if params[:query] == "save_scheme"

      scheme_params = JSON.parse(params[:data])
      @scheme_id = scheme_params["scheme_id"]
      @scheme = Scheme.find(@scheme_id)
      
      if @scheme.saving_scheme(scheme_params)
        render :json => { :answer => "сохранено"}
      end
          
    end

  end

  private

  def construction_params
    params.require(:construction).permit(:scheme_id, :element_id, :cordx, :cordy)
  end
end
