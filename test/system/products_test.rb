require "application_system_test_case"

class ProductTest < ActiveSupport::TestCase
  fixtures :products

end

def create
  @product = Product.new(product_params)
  respond_to do |format|
    if @product.save
      format.html { redirect_to @product,
        notice: "Product was successfully created." }
      format.json { render :show, status: :created,
        location: @product }
    else
      puts @product.errors.full_messages
      format.html { render :new,
        status: :unprocessable_entity }
      format.json { render json: @product.errors,
        status: :unprocessable_entity }
    end
  end
end

test "product is not valid without a unique title - i18n" do
  product = Product.new(title: products(:ruby).title,
                        description: "yyy",
                        price: 1,
                        image_url: "fred.gif")
  assert product.invalid?
  assert_equal [I18n.translate('errors.messages.taken')],
               product.errors[:title]
end
