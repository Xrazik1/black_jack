# frozen_string_literal: true

require_relative 'player'
require_relative 'dealer'
require_relative 'deck'

class Table
  attr_reader :player, :dealer, :round, :bank, :bet

  def initialize(player, dealer, bet)
    @bank           = 0
    @round          = 1
    @deck           = Deck.new
    @player         = player
    @dealer         = dealer
    @bet            = bet
  end

  def take_card
    @deck.take_first_card
  end

  def deal_cards(count, member)
    count.times do
      member.add_card(take_card)
    end
  end

  def split_prize
    @dealer.bank += @bank / 2
    @player.bank += @bank / 2
  end

  def give_prize(member)
    member.bank += @bank
  end

  def make_bet
    @player.bank -= @bet
    @dealer.bank -= @bet
    @bank += @bet * 2
  end

  def clear_table
    @bank = 0
    @deck = Deck.new
    @round += 1
    @player.clear_hands
    @dealer.clear_hands
  end

  def current_winner
    return nil if @player.score == @dealer.score
    return nil if @player.score > 21 && @dealer.score > 21

    return @dealer if @player.score > 21
    return @player if @dealer.score > 21

    return @dealer if (21 - @dealer.score) < (21 - @player.score)
    return @player if (21 - @player.score) < (21 - @dealer.score)
  end

  def check_members_money!
    raise 'У игрока недостаточно средств для начальной ставки' if (@player.bank - @bet).negative?
    raise 'У дилера недостаточно средств для начальной ставки' if (@dealer.bank - @bet).negative?
  end
end
