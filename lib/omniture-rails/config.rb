module OmnitureRails
  class Config
    include Singleton
    OPTIONS = %w{sc_directory prop_map tracking_account visitor_namespace noscript_img_src}
    attr_accessor *OPTIONS.collect{|o|o.to_sym}

    
    def set(config)
      case config
      when Hash: set_with_hash(config)
      when IO: set_with_io(config)
      when String: set_with_string(config)
      end
    end
    
    def set_with_hash(config)
      OPTIONS.each do |option|
        self.send("#{option}=", config[option]) if config[option]
      end
    end
    
    # String should be either a filename or YAML
    def set_with_string(config)
      if File.exists?(config)
        set_with_yaml(File.read(config))
      else
        set_with_yaml(config)
      end
    end
    
    def set_with_io(config)
      set_with_hash(YAML.load(config))
      config.close
    end
    
    def set_with_yaml(config)
      set_with_hash(YAML.load(config))
    end
  end
end