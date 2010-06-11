require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "OmnitureRails integration" do
  it "should return the final values using input, priority values, and the prop map" do
    input = {
      :action => "show",
      :filter => { :tags => "cat, shakespeare"}
    }
    
    class Context
      def keywords
        "juice mirror"
      end
      def filter_terms
        "cat shakespeare"
      end
    end
    
    priority_values = {:keywords => "tongue paper"}
    mapper_context = Context.new
    
    OmnitureRails.config.prop_map = {
      :keywords => :prop1,
      :filter_terms => :prop2
    }
    
    values = OmnitureRails.values_for(input, 'search.sc', priority_values, mapper_context)
    
    values.should == {
      :channel => "Search",
      :pageName => "Search Results",
      :prop1 => priority_values[:keywords],
      :prop2 => mapper_context.filter_terms
    }
  end
end
