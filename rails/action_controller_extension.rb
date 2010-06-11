module OmnitureRails
  module ActionControllerExtension
    extend Concern
    included do
      helper_attr :omniture_input, :omniture_priority_map
      before_filter :set_omniture_input
    end
    
    module ClassMethods
    end
    
    module InstanceMethods
      def set_omniture_input
        omniture_input = params
      end
    end
  end
end

ApplicationController.send(:include, OmnitureRails::ActionControllerExtension)