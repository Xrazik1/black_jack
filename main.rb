# frozen_string_literal: true

require_relative 'table'
require_relative 'dealer'
require_relative 'player'
require_relative 'ui'

def run_game_process(game)
  sleep(1)
  game[:table].deal_cards(2, game[:table].player)
  game[:table].deal_cards(2, game[:table].dealer)
  game[:ui].show_players_cards(game[:table])
  game[:ui].show_player_score(game[:table].player.score)
  game[:table].make_bet
  sleep(1)
  game[:ui].show_bet_info(game[:table])

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
    game[:ui].show_step_info('Вы добавили карту')

    if game[:table].dealer.make_move(game[:table]) == 'skip'
      game[:ui].show_step_info('Дилер пропускает ход')
    else
      game[:ui].show_step_info('Дилер берёт карту')
    end
    sleep(1)

    game[:ui].show_players_cards(game[:table])
    game[:ui].show_player_score(game[:table].player.score)

    { continue?: true, game: game }
  elsif choice == 2
    if game[:table].dealer.make_move(game[:table]) == 'skip'
      game[:ui].show_step_info('Дилер пропускает ход')
    else
      game[:ui].show_step_info('Дилер берёт карту')
    end
    sleep(1)

    game[:ui].show_players_cards(game[:table])
    game[:ui].show_player_score(game[:table].player.score)

    { continue?: true, game: game }
  elsif choice == 3
    game[:table] = game[:ui].handle_results(game[:table])

    { continue?: false, game: game }
  end
end

def make_choice(game)
  if game[:table].player.cards.size > 2
    game[:ui].show_error_message('Игроки достигли максимального колличества карт')
    sleep(1)
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

  game[:ui].ask_for_continue(game[:table].round)
  game_repeater(run_game_process(game))
end

def main(game)
  game = init_game(game)

  game[:ui].show_greeting(game[:table].player.name)
  game[:ui].show_player_balance(game[:table].player.bank)
  game[:ui].ask_for_continue(game[:table].round)

  game_repeater(run_game_process(game))
rescue RuntimeError => e
  puts e.message
  game[:ui].show_error_message('У одного из игроков закончились деньги, завершение игры')
  abort
end

main({})
