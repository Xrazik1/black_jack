# frozen_string_literal: true

class Member
  attr_accessor :bank
  attr_accessor :cards

  def initialize
    @cards = []
    @bank = 100
  end
end

