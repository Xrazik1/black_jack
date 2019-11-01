# frozen_string_literal: true

require_relative 'member'
require_relative 'card'

class Dealer < Member
  def initialize
    super()
  end

  def read_cards_sum
    sum = 0
    (@cards.reject { |card| card.value == 'A' }).each { |card| sum += card.card_worth(card.value) }
    sum + read_aces_sum(sum)
  end

  def make_move

  end

  private

  def read_aces_sum(init_sum)
    sum = 0
    if init_sum + 11 > 21
      (@cards.select { |card| card.value == 'A' }).each { |ace| sum += ace.card_worth('A')[0] }
    else
      (@cards.select { |card| card.value == 'A' }).each { |ace| sum += ace.card_worth('A')[1] }
    end
    sum
  end
end

dealer = Dealer.new
puts dealer.read_cards_sum
