# frozen_string_literal: true

require_relative 'member'

class Player < Member
  def initialize(name)
    super()
    @name = name
  end



end
