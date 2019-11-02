# frozen_string_literal: true

require_relative 'member'

class Player < Member
  attr_reader :name

  def initialize(name)
    super()
    @name = name
  end
end
