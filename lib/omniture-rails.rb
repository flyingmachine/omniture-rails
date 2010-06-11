require 'singleton'
require 'omniture-rails/applier'
require 'omniture-rails/config'
require 'omniture-rails/node'
require 'omniture-rails/parser'
require 'omniture-rails/value'

module OmnitureRails
  class << self
    def config
      OmnitureRails::Config.instance
    end
    
    def values_for(input, selector_config, priority_map, mapper_context)
      tree = tree_for_selector_config(selector_config)      
      values = OmnitureRails::Applier.new(input, tree, priority_map, mapper_context).result
      OmnitureRails.config.prop_map.each do |business_name, prop_name|
        values[prop_name] = values.delete(business_name)
      end
      values
    end
    
    def tree_for_selector_config(selector_config)
      case selector_config
      when String
        possible_file_path = File.join(OmnitureRails.config.sc_directory, selector_config)
        selector_config = File.read(possible_file_path) if File.exists?(possible_file_path)
        OmnitureRails::Parser.new(selector_config).to_tree
      when OmnitureRails::Node
        selector_config
      end
    end
  end
end