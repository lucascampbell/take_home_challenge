# * wholesale price
# * retail price
# * type - pants, shirts, dresses, skirts, other
# * name
class Style < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  #enum type: ["pants", "shirts", "dresses","skirts","other"]
  has_many :items
end
