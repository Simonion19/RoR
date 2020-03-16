print 'Enter a: '
a = gets.chomp.to_i

print 'Enter b: '
b = gets.chomp.to_i

print 'Enter c: '
c = gets.chomp.to_i

D = b**2 - 4 * a * c

if D > 0
    root1 = (-b + Math.sqrt(D)) / 2 * a
    root2 = (-b - Math.sqrt(D)) / 2 * a
    puts "Корни: #{root1}, #{root2}"
    puts "Дискриминант: #{D}"
elsif D == 0
    root = -b / 2 * a
    puts "Корень: #{root}"
    puts "Дискриминант: #{D}"
elsif D < 0
    puts "Корней нет"
    puts "Дискриминант: #{D}"
end