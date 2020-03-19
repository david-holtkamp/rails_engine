require_relative 'modules/priceable'

class Item < ApplicationRecord
  include Priceable

  before_create :convert_to_dollars
end