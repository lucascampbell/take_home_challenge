# * size
# * color
# * status - sellable, not sellable, sold, clearanced
# * price sold
# * date sold
class Item < ActiveRecord::Base
  ITEM_STATUS          = ["sellable", "not sellable", "sold","clearanced"]
  CLEARANCE_PRECENTAGE = 0.75
  belongs_to :style
  belongs_to :report

  validates :size, presence: true
  validates :color, presence: true
  validates :status, inclusion: {in: ITEM_STATUS}

  def self.clearanced(ids)
    where("id IN (?) and status != ?",ids,'sold')
  end

  def clearance_price
    self.style.wholesale_price * CLEARANCE_PRECENTAGE
  end

  def min_sold_price
    price = self.clearance_price
    case self.style.type.downcase
    when 'pants','dresses'
      if(price < 5)
        self.price_sold = 5
      else
        self.price_sold = price
      end
    else
      if(price < 2)
        self.price_sold = 2
      else
        self.price_sold = price
      end
    end
  end
end
