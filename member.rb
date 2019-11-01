# frozen_string_literal: true

require_relative 'card'

class Member
  attr_accessor :bank, :cards

  def initialize
    @cards = []
    @bank = 100
    @score = 0
  end

  def add_card(card)
    @cards << card
    @score = read_cards_sum
  end

  def remove_card(card)
    @cards.delete(card)
    @score = read_cards_sum
  end

  def read_cards_sum
    sum = 0
    (@cards.reject { |card| card.value == 'A' }).each { |card| sum += card.card_worth(card.value) }
    sum + read_aces_sum(sum)
  end

  protected

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
