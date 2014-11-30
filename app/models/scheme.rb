class Scheme < ActiveRecord::Base
	
	validates  :title, presence: true
  validates  :short_description, presence: true
  validates  :description,  length: {
    maximum: 1000,
    too_long: "%{count} characters is the maximum allowed"}
  has_attached_file :scheme_image,
    :styles => { medium: "150x150>", thumb: "50x50>" },
    :default_url => '/images/:attachment/no_scheme_image_:style.jpg'

  do_not_validate_attachment_file_type :scheme_image

  belongs_to :user

  has_many   :constructions, dependent: :destroy
  has_many   :elements, through: :constructions

  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  has_many :comments

  def average_rating
    @value = 0
    self.ratings.each do |rating|
        @value += rating.value
    end
    @total = self.ratings.size
    unless @value.zero?
      rating = @value.to_f / @total.to_f
      self.update_column(:rating, rating.round(1))
      rating
    else 
      "0"
    end
  end

  def self.load_scheme

      @objects = []

      self.constructions.each do |construction|
        
        @elem = {}

        construction.parametrs.each do |parametr|
          @elem[parametr.name] = parametr.value
        end

        obj = {}
        obj[:id] = construction.element.id
        obj[:type] = construction.tips
        obj[:obj] = @elem
        @objects << obj
      end
      @objects
  end

  def saving_scheme(params)

    self.constructions.each do |x|
      x.destroy
    end

    a_file = File.new("#{Rails.root}/public/scheme_image.png", "w+" )

    img = params["scheme_image"].gsub!(" ", "+")
    base64_image_string = StringIO.new(Base64.decode64(img))
    self.scheme_image = base64_image_string
    self.save

    (0...(params["elements"].length)).each do |i|
         
      @construction = Construction.new
      @construction.scheme_id = self.id
      @construction.tips = params["elements"][i]["type"]
      @construction.element_id = params["elements"][i]["obj_data"]["element_id"].to_i if params["elements"][i]["obj_data"].include? "element_id"

      unless params["elements"][i]["obj_properties"].blank?
        (0...params["elements"][i]["obj_properties"].length).each do |p|

          @scheme_element_property = SchemeElementProperty.new

          @scheme_element_property.property_id = params["elements"][i]["obj_properties"][p]["id"]
          @scheme_element_property.value = params["elements"][i]["obj_properties"][p]["value"]

          @construction.scheme_element_properties << @scheme_element_property
        end
      end

      params["elements"][i]["obj_data"].each do |key, value|
        @parametr = Parametr.new
        @parametr[:name] = key
        @parametr[:value] = value

        @construction.parametrs << @parametr
      end
binding.pry
      unless params["elements"][i]["obj_properties"].blank?
        @construction.parametrs << Parametr.new(:name => "image", :value => @construction.element.image.url(:thumb))
      end
      @construction.save do
        @construction.scheme_element_properties.create
        @construction.parametrs.create
      end

    end
  end

end
