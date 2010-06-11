require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "OmnitureRails integration" do
  before :each do
    @input = {
      :action => "show",
      :filter => { :tags => "cat, shakespeare"}
    }
    @mapper_context = Context.new
  end
  
  it "should return the final values using input, sc filename, priority values, and the prop map" do
    OmnitureRails.config.prop_map = {
      :keywords => :prop1,
      :filter_terms => :prop2
    }
    
    priority_values = {:keywords => "tongue paper"}
    values = OmnitureRails.values_for(@input, 'search.sc', priority_values, @mapper_context)
    
    values.should == {
      :channel => "Search",
      :pageName => "Search Results",
      :prop1 => priority_values[:keywords],
      :prop2 => @mapper_context.filter_terms
    }
  end

  it "should allow you to use an existing tree instead of an sc filename" do
    tree = OmnitureRails::Parser.new(File.read(File.join(OmnitureRails.config.sc_directory, 'search.sc'))).to_tree
    values = OmnitureRails.values_for(@input, tree, {}, @mapper_context)

    values.should == {
      :channel => "Search",
      :pageName => "Search Results",
      :prop1 => @mapper_context.keywords,
      :prop2 => @mapper_context.filter_terms
    }
  end
end
