# frozen_string_literal: true

require_relative 'member'
require_relative 'card'

class Dealer < Member
  attr_reader :name

  def initialize
    super()
    @name = 'Дилер'
  end

  def make_move(table)
    add_card(table.take_card) if @score < 17
  end
end
