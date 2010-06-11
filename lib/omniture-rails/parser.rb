module OmnitureRails
  class Parser
    attr_accessor :source
    
    def initialize(source)
      @source = source
    end
    
    def to_tree
      current_node = Node.new
      node_stack = [current_node]
      indentation_level = 0
      
      source.each_line do |line|
        next if line.strip.empty?
        line = Line.new(line)
        
        if line.type == :value
          # Every drop in indentation corresponds to a new node;
          # It doesn't make sense to drop indentation level and 
          # define further values
          raise SyntaxError, "you must define all values before any sub-selctors" if line.indentation_level < indentation_level
          current_node.values << line.to_value
        else
          if line.indentation_level >= indentation_level
            node_stack.push current_node
          else
            node_stack_to_pop = indentation_level - line.indentation_level - 1
            node_stack.slice!(node_stack.size - node_stack_to_pop, node_stack.size)
          end
          current_node = Node.new
          current_node.selector = line.to_selector
          node_stack.last.children << current_node
        end
        indentation_level = line.indentation_level        
      end
      node_stack[0]
    end
    
    
    class Line
      VALUE_INDICATOR = 58
      
      attr_reader :source, :stripped_source
      
      def initialize(source)
        @source = source
        @stripped_source = source.strip
      end
      
      # Every two spaces is one indentation level
      def indentation_level
        spaces = (@source.size - @stripped_source.size)
        spaces == 0 ? 0 : spaces / 2
      end
      
      def type
        @stripped_source[0] == VALUE_INDICATOR ? :value : :selector
      end
      
      def to_selector
        selector = {}
        @stripped_source.split(" ").each do |pair|
          key, value = pair.split(":")
          selector[key.to_sym] = value || nil
        end
        selector
      end
      
      def to_value
        Value.new(self)
      end
    end
  end
end