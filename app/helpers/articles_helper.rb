module ArticlesHelper
  
  def generate_color_code
    hex_array = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"] #will be able to index hex digits with this
    max = hex_array.length #random number needs to be between 0 and 15
    
    #need to generate 6 characters
    code = '#'
    0.upto(5) {
      index = rand(max)
      code << hex_array[index]
    }
    code + ";"
  end
end
