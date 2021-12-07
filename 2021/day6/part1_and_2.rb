fresh_fish = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0}
fish = fresh_fish.merge(ARGF.read.split(",").map(&:to_i).tally)

days = 256
while days > 0
  temp_fish = fish.dup
  fish.keys.reverse_each do |timer|
    if timer == 0
      temp_fish[8] += fish[0]
      temp_fish[6] += fish[0]
    else
      temp_fish[timer - 1] = fish[timer]
      temp_fish[8] = 0 if timer == 8
    end
  end

  days -= 1
  fish = temp_fish
end

puts "answer: #{fish.values.sum}"
