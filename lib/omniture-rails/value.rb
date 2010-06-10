module OmnitureRails
  class Value
    attr_accessor :type, :key, :pre_value
    
    def initialize(line)
      match = /:(.*?)(=?) (.*)$/.match(line.stripped_source)
      @key = match[1].to_sym
      @pre_value = match[3]
      @type = match[2].empty? ? :static : :dynamic
    end
    
    
  end
end
