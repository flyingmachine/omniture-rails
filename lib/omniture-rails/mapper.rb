module OmnitureRails
  class Mapper
    include Singleton
    class << self
      def define_map(&block)
        self.instance.instance_eval(&block)
      end
      
      def map(map_hash)
        {:pageName => "Search"}
      end
    end
    
    def map(*args, &block)
      
    end
  end
end