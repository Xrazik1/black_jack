# frozen_string_literal: true

class Card
  attr_reader :value, :suite

  POSSIBLE_SUITS = %w[♥️ ♠️ ♣️ ♦️].freeze
  POSSIBLE_VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize(value, suite)
    @value = value
    @suite = suite

    unless POSSIBLE_SUITS.include?(suite) || POSSIBLE_VALUES.include?(value)
      raise 'Карту с такой мастью и достоинством создать невозможно'
    end
  end

  def card_worth(value)
    raise 'Карты такого достоинства не существует' unless POSSIBLE_VALUES.include?(value)

    return value.to_i if POSSIBLE_VALUES[0..9].include?(value)
    return 10 if POSSIBLE_VALUES[9..11].include?(value)
    return [1, 11] if POSSIBLE_VALUES[12].include?(value)
  end
end

