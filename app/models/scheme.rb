class Scheme < ActiveRecord::Base
	
	validates  :title, presence: true
  validates  :short_description, presence: true

  belongs_to :user

  has_many   :constructions
  has_many   :elements, through: :constructions

  has_many :ratings
  has_many :raters, :through => :ratings, :source => :user

  def average_rating
    @value = 0
    self.ratings.each do |rating|
        @value += rating.value
    end
    @total = self.ratings.size
    unless @value.zero?
      rating = @value.to_f / @total.to_f
      self.update(:rating => rating) if rating != self.rating
      rating
    else 
      "0"
    end
  end

end
