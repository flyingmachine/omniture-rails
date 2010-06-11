require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "OmnitureRails::Mapper" do
  it "should use a tree to build a result from input" do
    tree = OmnitureRails::Parser.new(File.read(File.join(OmnitureRails.config.sc_directory, 'search.sc'))).to_tree
    
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
    
    values = OmnitureRails::Mapper.new(input, tree, priority_values, mapper_context).result
    
    values.should == {
      :channel => "Search",
      :pageName => "Search Results",
      :keywords => priority_values[:keywords],
      :filter_terms => mapper_context.filter_terms
    }
  end
end