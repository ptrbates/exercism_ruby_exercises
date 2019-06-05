module ETL
  def self.transform(old_table)
    old_table.each_with_object({}) do |(value, letters), new_table|
      letters.each { |letter| new_table[letter.downcase] = value }
    end
  end
end
