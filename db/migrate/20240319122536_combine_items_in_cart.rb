class CombineItemsInCart < ActiveRecord::Migration[7.0]
  # def up
  #   # 將購物車中同一產品的多個項目替換為單個項目
  #   Cart.all.each do |cart|
  #     # 計算購物車中每個產品的數量
  #     sums = cart.line_items.group(:product_id).sum(:quantity)
  #     sums.each do |product_id, quantity|
  #       if quantity > 1
  #         # 刪除個別項目
  #         cart.line_items.where(product_id: product_id).delete_all
  #         # 替換為單個項目
  #         item = cart.line_items.build(product_id: product_id)
  #         item.quantity = quantity
  #         item.save!
  #       end
  #     end
  #   end
  # end

  def down
    # split items with quantity>1 into multiple items
    LineItem.where("quantity>1").each do |line_item|
      # add individual items
      line_item.quantity.times do
        LineItem.create(
          cart_id: line_item.cart_id,
          product_id: line_item.product_id,
          quantity: 1
        )
      end
      # remove original item
      line_item.destroy
    end
  end
  
end
