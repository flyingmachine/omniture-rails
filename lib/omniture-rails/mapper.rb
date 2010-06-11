module OmnitureRails
  class Mapper
    def initialize(input, tree, priority_values, mapper_context)
      @input = input
      @tree = tree
      @mapper_context = mapper_context
      @priority_values = priority_values
    end
    
    def result
      @result = {}
      apply_tree
      @result.merge(@priority_values)
    end
    
    def apply_tree
      apply_node(@tree)
    end
    
    def apply_node(node)
      if node.selector.nil? || selector_matches?(node.selector)
        apply_values(node.values)
        node.children.each do |child_node|
          apply_node(child_node)
        end
      end
    end
    
    def apply_values(node_values)
      node_values.each do |value|
        next if priority_keys.include? value.key
        if value.static?
          @result[value.key] = value.pre_value
        else
          @result[value.key] = @mapper_context.instance_eval(value.pre_value)
        end
      end
    end
    
    def selector_matches?(selector)
      selector.keys.all? do |key|
        @input[key] == selector[key] || selector[key].nil? && @input.has_key?(key)
      end
    end
    
    def priority_keys
      @priority_keys ||= @priority_values.keys
    end
  end
end
