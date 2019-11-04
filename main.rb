# frozen_string_literal: true

require_relative 'table'
require_relative 'dealer'
require_relative 'player'
require_relative 'ui'

def run_game_process(game)
  puts 'Выполняется раздача карт...'
  game[:table].deal_cards(2, game[:table].player)
  game[:table].deal_cards(2, game[:table].dealer)
  game[:ui].show_players_cards(game)
  puts "<> Сумма ваших очков: #{game[:table].player.score}"
  game[:table].make_bet
  puts "В банк сделана ставка в размере #{game[:table].bet}$, текущий размер банка: #{game[:table].bank}$"
  make_choice(game)
end

def init_game(game)
  return game unless game.empty?

  ui = Ui.new
  dealer = Dealer.new
  player = Player.new(ui.take_name)
  table = Table.new(player, dealer, 10)

  { table: table, ui: ui }
rescue RuntimeError => e
  puts e.message
  init_game(game)
end

def choice_handler(choice, game)
  if choice == 1
    game[:table].deal_cards(1, game[:table].player)
    puts 'Вы добавили карту'
    game[:ui].show_players_cards(game)
    puts "<> Сумма ваших очков: #{game[:table].player.score}"

    { continue?: true, game: game }
  elsif choice == 2
    game[:table].dealer.make_move(game[:table])
    game[:ui].show_players_cards(game)
    puts "<> Сумма ваших очков: #{game[:table].player.score}"

    { continue?: true, game: game }
  elsif choice == 3
    game[:table] = game[:ui].handle_results(game[:table])

    { continue?: false, game: game }
  end
end

def make_choice(game)
  if game[:table].player.cards.size > 2
    puts 'Игроки достигли максимального колличества карт'
    game[:table] = game[:ui].handle_results(game[:table])

    game
  else
    game[:ui].print_steps
    choice = game[:ui].take_menu_number(1..3)
    game_result = choice_handler(choice, game)
    make_choice(game) unless game_result[:continue?] == false

    game_result[:game]
  end
rescue RuntimeError => e
  puts e.message
  make_choice(game)
end

def game_repeater(game)
  game[:table].clear_table
  game[:table].check_members_money!

  puts "Ваш баланс: #{game[:table].player.bank}$"
  game[:ui].ask_for_continue(game[:table].round)
  game_repeater(run_game_process(game))
end

def main(game)
  game = init_game(game)

  puts "Здравствуйте, #{game[:table].player.name}, добро пожаловать в игру блэкджек"
  puts "Ваш баланс: #{game[:table].player.bank}$"
  game[:ui].ask_for_continue(game[:table].round)

  game_repeater(run_game_process(game))
rescue RuntimeError => e
  puts e.message
  abort('У одного из участников закончились деньги, завершение игры')
end

main({})
