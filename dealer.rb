# frozen_string_literal: true

require_relative 'member'
require_relative 'card'

class Dealer < Member
  attr_reader :name

  def initialize
    super()
    @name = 'Дилер'
  end

  def make_move

  end
end
