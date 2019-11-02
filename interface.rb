# frozen_string_literal: true

class Interface
  def take_name
    print 'Введите ваше имя: '
    name = gets.chomp
    raise 'Имя не может быть пустой строкой' if name == ''

    name
  end

  def take_menu_number(numbers)
    numbers.each(&:to_s)

    print 'Выберите пункт меню'
    number = gets.chomp.strip
    raise 'Пункт меню не может быть пустым' if number == ''
    raise 'Такого пункта меню не существует' if numbers.include?(number)

    number
  end

end
