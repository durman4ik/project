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
      

      #@scheme_id = 47 #!!!!!!!!!!!!!!!!
      @scheme = Scheme.find(47)

      @objects = []

      @scheme.constructions.each do |construction|
        @h={}
        @h[:id] = construction.element_id
        @h[:x] = construction.cordx
        @h[:y] = construction.cordy
        @h[:width] = construction.width
        @h[:height] = construction.height
        @h[:connections] =  construction.element.num_inputs
        @h[:image] = construction.element.image.url(:thumb)
        @h[:color] = "blue"
      end


      elem1 = {:id=> 10, :x=>20, :y=>40, :width => 50, :height => 50, :connections=> 3, :image => 'assets/1.jpg', :color => 'blue'}
      elem2 = {:id=> 12, :x=>60, :y=>100, :width => 50, :height => 50, :connections=> 3, :image => 'assets/2.jpg', :color => 'black'}

      obj1={:id=>10, :type =>'SchemeElement', :obj => @h}
      obj2={:id=>11, :type =>'SchemeElement', :obj => elem2}

      render :json => { :answer => 'держи массив обьектов', :data=>[obj1] }

    end

    if params[:query] == "save_scheme"

      scheme_params = JSON.parse(params[:data])
      @scheme_id = scheme_params["scheme_id"]

      @scheme = Scheme.find(@scheme_id)
      @scheme.scheme_image = StringIO.new(Base64.decode64("data:image/jpeg;base64,#{scheme_params["scheme_image"]}"))

          (0...(scheme_params["elements"].length)).each do |i|

            case scheme_params["elements"][i]["type"]

              when "SchemeElement"
                # ДОБАВИТЬ СЮДА find_by scheme_id и id_on_scheme ????!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                if Construction.find_by(:scheme_id => @scheme_id, :cordx => scheme_params["elements"][i]["obj_data"]["x"],
                                                      :cordy => scheme_params["elements"][i]["obj_data"]["y"]).nil?

                  @construction = Construction.new
                  @construction.scheme_id = @scheme_id
                  @construction.cordx = scheme_params["elements"][i]["obj_data"]["x"]
                  @construction.cordy = scheme_params["elements"][i]["obj_data"]["y"]
                  @construction.width = scheme_params["elements"][i]["obj_data"]["width"]
                  @construction.height = scheme_params["elements"][i]["obj_data"]["height"]
                  # @construction.id_on_scheme = i
                  # @construction.color = scheme_params["elements"][i]["obj_data"]["color"] !!!!!!!!!!!!!!!!!!!!

                  (0...scheme_params["elements"][i]["obj_properties"].length).each do |p|

                    @scheme_element_property = SchemeElementProperty.new

                    @scheme_element_property.property_id = scheme_params["elements"][i]["obj_properties"][p]["id"]
                    @scheme_element_property.value = scheme_params["elements"][i]["obj_properties"][p]["value"]

                    @construction.scheme_element_properties << @scheme_element_property
                  end
                  
                  @construction.save do
                    @construction.scheme_element_properties.create
                  end

                else
                  # # ДОБАВИТЬ СЮДА find_by scheme_id и id_on_scheme ????!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                  # @construction = Construction.find_by(:scheme_id => @scheme_id, 
                  #                                     :cordx => scheme_params["elements"][i]["obj_data"]["x"],
                  #                                     :cordy => scheme_params["elements"][i]["obj_data"]["y"])

                  # @construction.cordx = scheme_params["elements"][i]["obj_data"]["x"]
                  # @construction.cordy = scheme_params["elements"][i]["obj_data"]["y"]
                  # @construction.width = scheme_params["elements"][i]["obj_data"]["width"]
                  # @construction.height = scheme_params["elements"][i]["obj_data"]["height"]

                  # (0...scheme_params["elements"][i]["obj_properties"].length).each do |p|
                  # #@scheme_element_property = 
                  #   end
                  
                end

              when "SchemeLine" 
                #@line = Line.new
            end

            
          end
          
    end

  end

  private

  def construction_params
    params.require(:construction).permit(:scheme_id, :element_id, :cordx, :cordy)
  end
end
