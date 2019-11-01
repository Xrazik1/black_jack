# frozen_string_literal: true

require_relative 'card'


class Table
  attr_reader :deck

  def initialize
    @bank = 0
    @deck = init_deck
  end

  private

  def init_deck
    deck = []
    Card::POSSIBLE_VALUES.each do |value|
      Card::POSSIBLE_SUITS.each do |suit|
        deck << Card.new(value, suit)
      end
    end
    deck.shuffle
  end
end

table = Table.new
table.deck.each do |card|
  puts card.value + card.suit
end

