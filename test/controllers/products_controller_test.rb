require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
  end

  test "should update product" do
    patch product_url(@product), params: {
      product: {
        description: @product.description,
        image_url: @product.image_url,
        price: @product.price,
        title: @title,
      }
    }
    assert_redirected_to product_url(@product)
  end
  
end
