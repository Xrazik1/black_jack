# frozen_string_literal: true

require_relative 'card'
require_relative 'dealer'

class Table
  attr_reader :deck, :players

  def initialize(player, dealer)
    @bank = 0
    @deck = init_deck
    @player = player
    @dealer = dealer
  end

  def take_card
    card = @deck[0]
    @deck.delete(card)
    card
  end

  def make_bet(bet = 10)
    raise 'У игрока недостаточно средств для совершения ставки' if (@player.bank - bet).negative?
    raise 'У дилера недостаточно средств для совершения ставки' if (@dealer.bank - bet).negative?

    @player.bank -= bet
    @dealer.bank -= bet
    @bank += bet * 2
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


