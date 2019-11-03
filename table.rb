# frozen_string_literal: true

require_relative 'card'
require_relative 'player'
require_relative 'dealer'

class Table
  attr_reader :player, :dealer, :round, :bank, :bet

  def initialize(player, dealer, bet)
    @bank           = 0
    @round          = 1
    @deck           = init_deck
    @player         = player
    @dealer         = dealer
    @bet            = bet
  end

  def take_card
    card = @deck[0]
    @deck.delete(card)
    card
  end

  def deal_cards(count, member)
    count.times do
      @dealer.add_card(take_card) if member.instance_of?(Dealer)
      @player.add_card(take_card) if member.instance_of?(Player)
    end
  end

  def make_bet
    @player.bank -= @bet
    @dealer.bank -= @bet
    @bank += @bet * 2
  end

  def clear_table
    @bank = 0
    @deck = init_deck
    @round += 1
    @player.clear_hands
    @dealer.clear_hands
    puts @player.cards.inspect
  end

  def current_winner
    if @player.score < @dealer.score && @dealer.score < 21
      @dealer
    elsif @dealer.score < @player.score && @player.score < 21
      @player
    else
      false
    end
  end

  def check_members_money!
    raise 'У игрока недостаточно средств для начальной ставки' if (@player.bank - @bet).negative?
    raise 'У дилера недостаточно средств для начальной ставки' if (@dealer.bank - @bet).negative?
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
