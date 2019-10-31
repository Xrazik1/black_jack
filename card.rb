# frozen_string_literal: true

class Card
  attr_reader :cards_symbols
  attr_reader :suits

  def initialize
    @suits = %w[♥️ ♠️ ♣️ ♦️]
    @values = %w[2 3 4 5 6 7 8 9 10 J Q K A]
  end

  def card_worth(value)
    raise 'Карты такого достоинства не существует' unless @values.include?(value)

    return value.to_i if @values[0..9].include?(value)
    return 10 if @values[9..11].include?(value)
    return [1, 11] if @values[12].include?(value)
  end

end

card = Card.new
puts card.card_worth('2')
