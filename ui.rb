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
