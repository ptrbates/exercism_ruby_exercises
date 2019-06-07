class PhoneNumber
  def self.clean(number)
    PhoneNumberCleaner.new(number).number
  end
end

class PhoneNumberCleaner
  attr_reader :number

  def initialize(string)
    @number = extract_digits(string)
    @digits = number.length
    verify_number
  end

  private

  attr_reader :digits
  attr_writer :number

  def extract_digits(string)
    string.scan(/\d/).join
  end

  def verify_number
    verify_number_length
    clean_11_digit_number if digits == 11 && !number.nil?
    check_first_and_fourth_digits unless number.nil?
  end

  def verify_number_length
    self.number = (10..11).include?(digits) ? number : nil
  end

  def clean_11_digit_number
    self.number = number[0] == "1" ? number[1...digits] : nil
  end

  def check_first_and_fourth_digits
    first_and_third = [number[0].to_i, number[3].to_i]
    self.number = first_and_third.all? { |digit| (2..9).include?(digit) } ? number : nil
  end
end
