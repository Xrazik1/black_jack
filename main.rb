# frozen_string_literal: true

require_relative 'game'

def run_game_process(game)
  game[:table].deal_cards(2, game[:table].player)
  game[:table].deal_cards(2, game[:table].dealer)
  game[:ui].show_players_cards(game[:table])
  game[:ui].show_player_score(game[:table].player.score)
  game[:table].make_bet
  game[:ui].show_bet_info(game[:table])

  make_choice(game)
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

    game[:ui].show_players_cards(game[:table])
    game[:ui].show_player_score(game[:table].player.score)

    { continue?: true, game: game }
  elsif choice == 2
    if game[:table].dealer.make_move(game[:table]) == 'skip'
      game[:ui].show_step_info('Дилер пропускает ход')
    else
      game[:ui].show_step_info('Дилер берёт карту')
    end

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
  game[:ui].show_error_message(e.message)
  retry
end

def game_repeater(game)
  game[:table].clear_table
  game[:table].check_members_money!

  game[:ui].ask_for_continue(game[:table].round)
  game_repeater(run_game_process(game))
end

def main
  game = Game.new
  game = game.controller

  game[:ui].show_greeting(game[:table].player.name)
  game[:ui].show_player_balance(game[:table].player.bank)
  game[:ui].ask_for_continue(game[:table].round)

  game_repeater(run_game_process(game))
rescue RuntimeError => e
  game[:ui].show_error_message("#{e.message}, завершение игры")
  abort
end

main
