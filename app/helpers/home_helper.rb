module HomeHelper
  
  def scheme_quantity
    Scheme.all.length
  end

  def top_schemes(schemes)
    @top_schemes = schemes.sort_by {|x|x.rating }
    @top_schemes[-5..-1].reverse
  end

end
