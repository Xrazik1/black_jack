# frozen_string_literal: true

class Interface
  def take_name
    print 'Введите ваше имя: '
    name = gets.chomp
    raise 'Имя не может быть пустой строкой' if name == ''

    name
  end

end
