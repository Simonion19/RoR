cart = {}
summ = 0

loop do
    print "Название товара: "
    name = gets.chomp
    break if name == 'стоп'
    print 'Кол-во товаров: '
    amount = gets.chomp.to_i
    print 'Цена за ед: '
    price = gets.chomp.to_f

    cart[name] = {'itemPrice': price, 'amount': amount, 'price': price * amount}
end

cart.each do |name, props|
    puts "#{name} - Кол-во: #{props[:amount]}, Цена за ед: #{props[:itemPrice]}, Общая цена: #{props[:price]}"
    summ += props[:price]
end

puts "Стоимость: #{summ}"
