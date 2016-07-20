class Bottles
  def verse(number)
    next_number = number - 1
    next_number_s = (next_number == 1) ? '' : 's'

    <<-END
#{number} bottles of beer on the wall, #{number} bottles of beer.
Take one down and pass it around, #{next_number} bottle#{next_number_s} of beer on the wall.
    END
  end
end
