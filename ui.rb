# frozen_string_literal: true

class Ui
  def take_name
    print 'Введите ваше имя: '
    name = gets.chomp
    raise 'Имя не может быть пустой строкой' if name == ''

    name
  end

  def show_player_score(score)
    puts "<> Сумма ваших очков: #{score}"
    sleep(1)
  end

  def show_player_balance(balance)
    puts "Ваш баланс: #{balance}$"
  end

  def show_greeting(name)
    puts "Здравствуйте, #{name}, добро пожаловать в игру блэкджек"
  end

  def show_error_message(message)
    puts "! #{message} !"
  end

  def show_step_info(info)
    puts "Ход: #{info}"
    sleep(1)
  end

  def show_bet_info(table)
    puts "В банк сделана ставка в размере #{table.bet}$, текущий размер банка: #{table.bank}$"
  end

  def take_menu_number(numbers)
    print 'Выберите пункт меню: '
    number = gets.chomp.to_i
    raise 'Пункт меню не может быть пустым' if number.nil?
    raise 'Такого пункта меню не существует' unless numbers.include?(number)

    number
  end

  def show_players_cards(table)
    print 'Карты дилера: '
    print_hidden_cards(table.dealer.cards)
    print "\nВаши карты: "
    print_cards(table.player.cards)
  end

  def print_steps
    puts '1. Добавить карту'
    puts '2. Пропустить ход'
    puts '3. Открыть карты'
  end

  def ask_for_continue(round)
    print "Начать раунд #{round}?(да, нет): "
    result = gets.chomp

    abort('Игра завершена') if result != 'да'
  end

  def handle_results(table)
    puts "Вскрытие карт игроков...\n----------"
    sleep(1)
    print 'Карты дилера: '
    print_cards(table.dealer.cards)
    puts "очки: #{table.dealer.score}"
    print 'Ваши карты: '
    print_cards(table.player.cards)
    puts "очки: #{table.player.score}"

    winner = 'Ничья'
    winner = table.current_winner unless table.current_winner.nil?
    puts "Результаты раунда #{table.round}:"
    if winner == 'Ничья'
      puts 'Произошла ничья, деньги возвращены игроку и дилеру'
      table.split_prize
    else
      puts "Победитель - #{winner.name}"
      table.give_prize(winner)
      puts "Банк(#{table.bank}$) переходит к победителю"
    end
    puts '----------'
    puts "Ваше количество денег - #{table.player.bank}$, дилера - #{table.dealer.bank}$"

    table
  end

  def print_cards(cards)
    cards.each do |card|
      print "|#{card.value}#{card.suit}| "
    end
  end

  def print_hidden_cards(cards)
    cards.each do
      print '|*| '
    end
  end
end
