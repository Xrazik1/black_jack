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
    table.deal_cards(1, self) if (@score < 17) && (cards.size < 3)
    'skip' if @score >= 17
  end
end
