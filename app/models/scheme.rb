class Scheme < ActiveRecord::Base
	
	validates  :title, presence: true
  validates  :short_description, presence: true
  validates  :description,  length: {
    maximum: 1000,
    too_long: "%{count} characters is the maximum allowed"}
  has_attached_file :scheme_image,
    :styles => { medium: "150x150>", thumb: "50x50>" }

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

end
