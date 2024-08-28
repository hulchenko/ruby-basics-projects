# Implement a caesar cipher that takes in a string and the shift factor and then outputs the modified string:
#  > caesar_cipher("What a string!", 5)
#  => "Bmfy f xywnsl!"


def caesar_cipher(string, shift_num)
  # 1. identify which string indexes are capitalized ----> alternatively this can be done as {index: 1, capitalized?: true, value: 'b'}
  # 2. return original array of numbers for each character
  # 3. subtract existing indexes with shift_num
  # 4. if index is negative, calculate negative from alphabet.length
  # 5. return modified array of numbers for each character
  # 6. capitalize modified characters from step 2
  alphabet = ('a'..'z').to_a

  original_map = get_original_index_map(alphabet, string);
  p original_map
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
  result = array.map do |char| # {:index=>22, :capitalized?=>true}
    if char.key?(:index)
      original_index = char[:index]
      if shift > original_index
        offset_index = get_index_offset(original_index, shift)
        char[:index] = offset_index
      else
        char[:index] = original_index.to_i - shift.to_i
      end
    end
    char # this is important to return
  end
  result
end

def get_index_offset(original_index, shift)
  alphabet_length = 26
  negative_offset = shift.to_i - original_index.to_i
  alphabet_length - negative_offset
end

def map_to_string_handler(alphabet, shifted_map)
  p shifted_map
  result = ''
  shifted_map.each do |char|
    if char.key?(:index) # proper alphabet character
      result += alphabet[char[:index]]
    end
  end
  p result
end

# TODO indexes should be added not subtracted

caesar_cipher("What a string!", 5)