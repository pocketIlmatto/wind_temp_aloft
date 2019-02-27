require "wind_temp_aloft/version"

module WindTempAloft
  class Instruct
    def initial_instruction
      puts 'WindTempAloft'
    end
  end

  class Wind
    attr_accessor :direction
    attr_accessor :speed
    attr_accessor :temperature

    def initialize(direction, speed, temperature)
      @direction = direction
      @speed = speed
      @temperature = temperature
    end

    def to_str
      "Direction: #{@direction}, Speed: #{@speed} kts, Temperature: #{@temperature} C"
    end

    def winds(altitude)
      {direction: @direction, speed: @speed, temperature: @temperature}
    end
  end

  class InputParser
    attr_reader :line, :line_data_array

    def initialize(line)
      @line = line
      @line_data_array = line.split(" ")
    end

    def airport_code
      # the airport_code will be always the second item
      code = line_data_array[1]
      code = code.strip.upcase if code.respond_to?(:strip)
      code
    end

    def command_type
      # the command_type will be always the first item
      line_data_array[0].downcase
    end

    def altitude
      line_data_array[2]
    end
  end

  class WindTempHandler
    attr_reader :data

    def initialize
      @data = get_data
    end

    def show(parsed_line)
      if airport_codes(@data).include?(parsed_line.airport_code)
        pretty_print(winds_temps_aloft(parsed_line.airport_code), parsed_line.altitude)
      else
        puts "Airport code #{parsed_line.airport_code} not recognized"
      end
    end

    def display_airport_codes
      puts airport_codes(@data)
    end

    def parse_info(passed_info)
      info =
        passed_info.class.to_s == 'Array' ? passed_info.join(" ") : passed_info
      parsed_line = passed_info != "\n" ? InputParser.new(info) : nil;
      if parsed_line.command_type == "show"
        self.show(parsed_line)
      elsif parsed_line.command_type == "codes"
        self.display_airport_codes
      else
        puts "command type not recognized"
      end
    end

  private
    def get_data
      wind_temp_aloft_lines = []
      f = File.open('./wind_temp_sample.txt', 'r')
      f.each_line do |line|
        wind_temp_aloft_lines << line
      end
      wind_temp_aloft_lines
    end

    def airport_codes(data)
      codes = []

      data.each do |line|
        md = /^([A-Z]{3})\s/.match(line)
        codes << md[1] if md
      end
      codes
    end

    def find_airport_line(code, data)
      data.each do |line|
        md = /^([A-Z]{3})\s/.match(line)
        return line if md && md[1] == code
      end
    end

    def parse_airport_line(line)
      raw_data = line[4..-1].gsub(/\s+/, ' ').strip.split(" ")

      altitudes = parse_altitudes(@data)
      padding = altitudes.length - raw_data.length
      
      padding.times do 
        raw_data.unshift('nana')
      end
      
      winds = altitudes.zip(raw_data).to_h
      winds.each_pair do |key, value|
        winds[key] = parse_raw(value)
      end
      winds
    end

    def parse_raw(raw)
      direction = 'na'
      speed = 'na'
      temperature = 'na'

      if raw[0..3] != '9900'
        direction = raw[0..1]
        speed = raw[2..3]
      end
      if direction.to_i.between?(51, 86)
        direction = (direction.to_i - 50).to_s
        speed = (speed.to_i + 100).to_s
      end
      speed = '200+' if speed.to_i == 99
      direction += '0' if direction != 'na'
      if raw.length >= 6
        temperature = raw[4..-1].strip
        temperature = "-#{temperature}" if raw.length == 6
      end

      Wind.new(direction, speed, temperature)
    end

    def parse_altitudes(data)
      altitudes = []
      data.each do |line|
        md = /^([A-Z]{2})\s/.match(line)
        if md && md[1] == 'FT'
          altitudes = line[4..-1].gsub(/\s+/, ' ').strip.split(" ")
          break
        end
      end
      altitudes
    end

    def pretty_print(winds, altitude = 'all')
      winds.each_pair do |key, value|
        puts "Altitude: #{key}' #{value.to_str}" if altitude == 'all' || altitude == key
      end
    end

    def winds_temps_aloft(code)
      airport_line = find_airport_line(code, @data)
      parse_airport_line(airport_line)
    end
  end
end  

