cart = {}
summ = 0

loop do
    print "Название товара: "
    name = gets.chomp
    break if name == 'стоп'
    print 'Кол-во товаров: '
    amount = gets.chomp
    print 'Цена за ед: '
    price = gets.chomp

    cart[name] = {'price': price, 'amount': amount}
end

cart.each do |name, props|
    puts "#{name} - Кол-во: #{props[:amount]}, Цена за ед: #{props[:price]}"
    summ += props[:amount].to_i * props[:price].to_i
end

puts "Стоимость: #{summ}"