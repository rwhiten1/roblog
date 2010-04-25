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
  
  def create_blocks(p_hash)
    rows = p_hash[:rows]
    columns = p_hash[:columns]
    width = p_hash[:width]
    height = p_hash[:height]
    css_class = p_hash[:class]
    
    top = 0
  	left = 0
  	html = ""
    0.upto(rows - 1) do |row|
      0.upto(columns -1) do |col|
        html += "<div id='block_#{row}_#{col}'"
        html += " class='#{css_class}' " if css_class
        html += "style='width: #{width}px; height: #{height}px; top: #{top}px; left: #{left}px; background-color: #{generate_color_code}'></div>\n"
        left = left + width
      end
      top = top + height
      left = 0
    end
    
    html.html_safe
  end
end
