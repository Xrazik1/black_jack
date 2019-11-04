# frozen_string_literal: true

require_relative 'member'
require_relative 'card'

class Dealer < Member
  attr_reader :name

  def initialize
    super()
    @name = 'Дилер'
  end

  def make_move(table)
    if (@score < 17) && (@cards.size < 3)
      table.deal_cards(1, self)
    else
      'skip'
    end
  end
end
