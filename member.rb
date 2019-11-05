# frozen_string_literal: true

require_relative 'card'

class Member
  attr_accessor :bank, :cards, :score

  def initialize
    @cards  = []
    @bank   = 100
    @score  = 0
  end

  def add_card(card)
    @cards << card
    @score = calc_cards_sum
  end

  def clear_hands
    @cards = []
    @score = 0
  end

  def calc_cards_sum
    sum = 0
    aces = @cards.select { |card| card.value == 'A' }
    (@cards.reject { |card| card.value == 'A' }).each { |card| sum += card.worth }
    include_aces_sum(aces, sum)
  end

  private

  def include_aces_sum(aces, sum)
    aces.each do |ace|
      min = ace.worth[:min]
      max = ace.worth[:max]
      sum += min if sum + max > 21
      sum += max if sum + max <= 21
    end
    sum
  end
end
