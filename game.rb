# frozen_string_literal: true

require_relative 'table'
require_relative 'dealer'
require_relative 'player'
require_relative 'ui'

class Game
  def initialize
    @ui = Ui.new
    @dealer = Dealer.new
    @player = Player.new(@ui.take_name)
    @table = Table.new(@player, @dealer, 10)

  rescue RuntimeError => e
    @ui.show_error_message(e.message)
    retry
  end

  def controller
    { ui: @ui, table: @table }
  end
end
