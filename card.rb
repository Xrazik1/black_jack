# frozen_string_literal: true

class Card
  attr_reader :value, :suit, :worth

  POSSIBLE_SUITS = %w[♠ ♣ ♥ ♦].freeze
  POSSIBLE_VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize(value, suit)
    @value  = value
    @suit   = suit
    @worth = get_worth(value)

    unless POSSIBLE_SUITS.include?(suit) || POSSIBLE_VALUES.include?(value)
      raise 'Карту с такой мастью и достоинством создать невозможно'
    end
  end

  private

  def get_worth(value)
    return value.to_i if POSSIBLE_VALUES[0..9].include?(value)
    return 10 if POSSIBLE_VALUES[9..11].include?(value)
    return { min: 1, max: 2 } if POSSIBLE_VALUES[12].include?(value)
  end
end
