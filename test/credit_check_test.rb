gem 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/credit_check'

class CreditCheckTest < Minitest::Test

  def test_it_can_gather_the_numbers_into_array_of_integers
    result = CreditCheck.new("4929735477250543")
    assert_equal [4, 9, 2, 9, 7, 3, 5, 4, 7, 7, 2, 5, 0, 5, 4, 3], result.splitter
  end

  def test_it_can_multiply_every_other_number_by_two_for_visa_mastercard
    result = CreditCheck.new("4929735477250543")
    assert_equal [8, 9, 4, 9, 14, 3, 10, 4, 14, 7, 4, 5, 0, 5, 8, 3], result.doubler_visa_mc
  end

  def test_it_can_remove_double_digits_by_subtracting_nine
    result = CreditCheck.new("4929735477250543")
    assert_equal [8, 9, 4, 9, 5, 3, 1, 4, 5, 7, 4, 5, 0, 5, 8, 3], result.remove_double_digits
  end

  def test_it_can_sum_all_numbers
    result = CreditCheck.new("4929735477250543")
    assert_equal 80, result.sum
  end

  def test_it_can_identify_a_valid_visa_mastercard_number
    result = CreditCheck.new("4929735477250543")
    assert result.check
  end

  def test_it_can_identify_a_valid_amex_number
    result = CreditCheck.new("342804633855673")
    assert result.check
  end

  def test_it_can_indentify_an_invalid_visa_mastercard_number
    result = CreditCheck.new("4024007106512380")
    refute result.check
  end

  def test_it_can_indentify_an_invalid_amex_number
    result = CreditCheck.new("342801633855673")
    refute result.check
  end

  def test_it_can_validate_a_valid_visa_mc_number
    result = CreditCheck.new("6011797668867828")
    result.check
    assert result.valid?, "The number is valid!"
  end

  def test_it_can_validate_an_invalid_visa_mc_number
    result = CreditCheck.new("6011797668868728")
    result.check
    refute result.valid?, "The number is invalid!"
  end

  def test_it_can_validate_a_valid_amex_number
    result = CreditCheck.new("342804633855673")
    result.check
    assert result.valid?, "The number is valid!"
  end

  def test_it_can_validate_an_invalid_amex_number
    result = CreditCheck.new("342801633855673")
    result.check
    refute result.valid?, "The number is invalid!"
  end

end
