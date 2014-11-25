module HomeHelper
  
  def scheme_quantity
    Scheme.all.length
  end

  def top_schemes(schemes)
    @top_schemes = schemes.order(:rating).reverse_order.limit(5)
  end

end
