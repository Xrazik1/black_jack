# frozen_string_literal: true

class Ui
  def take_name
    print 'Введите ваше имя: '
    name = gets.chomp
    raise 'Имя не может быть пустой строкой' if name == ''

    name
  end

  def take_menu_number(numbers)
    print 'Выберите пункт меню'
    number = gets.chomp.to_i
    raise 'Пункт меню не может быть пустым' if number.nil?
    raise 'Такого пункта меню не существует' if numbers.include?(number)

    number
  end

  def print_steps
    puts '1. Добавить карту'
    puts '2. Пропустить ход'
    puts '3. Открыть карты'
  end

  def ask_for_continue
    puts 'Продолжить игру?(да, нет): '
    result = gets.chomp.strip

    abort('Игра завершена') if result != 'да'
  end

  def print_results(table)
    puts 'Вскрытие карт игроков...'
    puts "Карты дилера: #{print_cards(table.dealer.cards)}, очков: #{print_cards(table.dealer.score)}"
    puts "Карты игрока: #{print_cards(table.player.cards)}, очков: #{print_cards(table.player.score)}"

    winner = 'Ничья'
    winner = table.current_winner.name if table.current_winner != false
    puts "Результаты раунда #{table.round}:"
    if winner == 'Ничья'
      puts 'Произошла ничья, деньги возвращены игроку и дилеру'
    else
      puts "Победитель - #{winner}"
      puts "Банк(#{table.bank}) переходит к победителю"
    end
    puts "Ваше количество денег - #{table.player.bank}$, дилера - #{table.dealer.bank}$"
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
