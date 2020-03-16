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

    cart[name] = {'itemPrice': price, 'amount': amount, 'price': price.to_i * amount.to_i}
end

cart.each do |name, props|
    puts "#{name} - Кол-во: #{props[:amount]}, Цена за ед: #{props[:itemPrice]}, Общая цена: #{props[:price]}"
    summ += props[:price].to_i
end

puts "Стоимость: #{summ}"