# frozen_string_literal: true

require_relative 'card'
require_relative 'player'
require_relative 'dealer'

class Table
  attr_reader :deck, :players

  def initialize(player, dealer, bet)
    @bank = 0
    @deck = init_deck
    @player = player
    @dealer = dealer
    @bet = bet
    @active_member = @player

    check_members_money!
  end

  def take_card
    card = @deck[0]
    @deck.delete(card)
    card
  end

  def skip_move(member)
    @active_member = member
  end

  def make_bet
    @player.bank -= @bet
    @dealer.bank -= @bet
    @bank += @bet * 2
  end

  def current_winner
    if @player.bank < @dealer.bank
      @dealer
    elsif @dealer.bank < @player.bank
      @player
    else
      false
    end
  end

  def check_members_money!
    raise 'У игрока недостаточно средств' if (@player.bank - @bet).negative?
    raise 'У дилера недостаточно средств' if (@dealer.bank - @bet).negative?
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


