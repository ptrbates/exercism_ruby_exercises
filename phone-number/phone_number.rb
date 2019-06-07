class PhoneNumber
  # version 2, based on solution by lujanfernaud https://exercism.io/tracks/ruby/exercises/phone-number/solutions/a8369d5bdb3543989dead726c03c4425

  VALID_PHONE_NUMBER = /^([2-9]\d{2}){2}\d{4}$/.freeze

  def self.clean(number)
    number = number.scan(/\d/).join.sub(/^1/, "")
    number[VALID_PHONE_NUMBER]
  end
end
