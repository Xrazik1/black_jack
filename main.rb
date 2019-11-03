# frozen_string_literal: true

require_relative 'table'
require_relative 'dealer'
require_relative 'player'
require_relative 'ui'

game = {}

def init_game(game)
  return game unless game.empty?

  ui = Ui.new
  dealer = Dealer.new
  player = Player.new(ui.take_name)
  table = Table.new(player, dealer, 10)

  { dealer: table.dealer, player: table.player, table: table, ui: ui }
end

def main(game)
  game = init_game(game)

  puts "Здравствуйте, #{game[:player].name}, добро пожаловать в игру блэкджек"
  puts "Ваш баланс: #{game[:player].bank}$"
  game[:ui].ask_for_continue(game[:table].round)
  game[:table].make_bet
  puts "В банк сделана ставка в размере #{game[:table].bet}$"
  puts 'Выполняется раздача карт...'
end

main(game)
