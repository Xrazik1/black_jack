# frozen_string_literal: true

require_relative 'member'
require_relative 'card'

class Dealer < Member
  def initialize
    super()
  end

  def make_move

  end

end

dealer = Dealer.new
puts dealer.read_cards_sum
