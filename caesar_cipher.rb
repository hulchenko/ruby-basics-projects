# Implement a caesar cipher that takes in a string and the shift factor and then outputs the modified string:
#  > caesar_cipher("What a string!", 5)
#  => "Bmfy f xywnsl!"


def caesar_cipher(string, shift_num)
  # 1. Identify current characters as alphabet indexes and if they are capitalized: {index: 1, capitalized?: true}
  # 2. Preserve non-alphabetic characters as they are: {value: '!'}
  # 3. Calculate offset based on index, shift and alphabet's length
  # 4. Return modified array of numbers for each character. For..each loop will take care of the original sequence of the nested objects in array
  # 5. Finally, capitalize modified characters, based on step 1 and return/print the value

  alphabet = ('a'..'z').to_a
  original_map = get_original_index_map(alphabet, string);
  shifted_map  = shift_original_index_map(original_map, shift_num)
  map_to_string_handler(alphabet, shifted_map)
end

def get_original_index_map(alphabet, string)
  result = [];
  original_string_array = string.split('')
  original_string_array.each do |char|
    if alphabet.include?(char.downcase)
        # string.index(char) <-- string index, don't need it I don't think
        result.push({
          index: alphabet.find_index(char.downcase),
          capitalized?: char == char.upcase
        })
    else
        result.push({ value: char })
    end
  end
  result
end

def shift_original_index_map(array, shift)
  alphabet_length = 26
  result = array.map do |char| # {:index=>22, :capitalized?=>true}
    if char.key?(:index)
      original_index = char[:index]
      if (shift + original_index) > alphabet_length
        offset_index = get_index_offset(original_index, shift, alphabet_length)
        char[:index] = offset_index
      else
        char[:index] = original_index.to_i + shift.to_i
      end
    end
    char # this is important to return
  end
  result
end

def get_index_offset(original_index, shift, alphabet_length)
  # e.g. 24 + 5 should equal to 3 <-- offset
  (original_index.to_i + shift.to_i) - alphabet_length
end

def map_to_string_handler(alphabet, shifted_map)
  result = ''
  shifted_map.each do |char|
    if char.key?(:index) and char.key?(:capitalized?) # identify proper alphabet character
      if char[:capitalized?]
        result += alphabet[char[:index]].upcase
      else
        result += alphabet[char[:index]]
      end
    end
    if char.key?(:value)
      # return non-alphabet character as-is
      result += char[:value]
    end
  end
  puts "Result: #{result}"
  result
end

caesar_cipher("What a string!", 5) # => "Bmfy f xywnsl!"