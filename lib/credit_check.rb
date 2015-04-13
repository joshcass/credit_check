class CreditCheck
attr_reader :card_number, :valid

  def initialize(card_number)
    @card_number = card_number
    @valid = false
  end

  def splitter
    card_number.scan(/\d/).map {|digit| digit.to_i}
  end

  def doubler_visa_mc
    numbers = splitter
    numbers.map.with_index do |n, i|
      if i.even?
        n * 2
      else
        n
      end
    end
  end

  def doubler_amex
    numbers = splitter
    numbers.map.with_index do |n, i|
      if i.odd?
        n * 2
      else
        n
      end
    end
  end

  def remove_double_digits
    if card_number.size == 15
      numbers = doubler_amex
    else
      numbers = doubler_visa_mc
    end

    numbers.map do |n|
      if n >= 10
        n - 9
      else
        n
      end
    end
  end

  def sum
    numbers = remove_double_digits
    numbers.reduce do |sum, n|
      sum += n
    end
  end

  def check
    number = sum
    @valid = true if number % 10 == 0
  end

  def valid?
    if valid
      puts "The number is valid!"
    else
      puts "The number is invalid!"
    end
    valid
  end

end


