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
    
    def values_for(input, selector_config, priority_values, mapper_context)
      possible_file_path = File.join(OmnitureRails.config.sc_directory, selector_config)
      selector_config = File.read(possible_file_path) if File.exists?(possible_file_path)
      tree = OmnitureRails::Parser.new(selector_config).to_tree
      values = OmnitureRails::Applier.new(input, tree, priority_values, mapper_context).result
      OmnitureRails.config.prop_map.each do |business_name, prop_name|
        values[prop_name] = values.delete(business_name)
      end
      values
    end
  end
end