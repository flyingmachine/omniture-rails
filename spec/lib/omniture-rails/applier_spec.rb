require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "OmnitureRails::Applier" do
  it "should use a tree to build a result from input" do
    tree = OmnitureRails::Parser.new(File.read(File.join(OmnitureRails.config.sc_directory, 'search.sc'))).to_tree
    
    input = {
      :action => "show",
      :filter => { :tags => "cat, shakespeare"}
    }
    
    priority_map = {:keywords => "tongue paper"}
    mapper_context = Context.new
    
    values = OmnitureRails::Applier.new(input, tree, priority_map, mapper_context).result
    
    values.should == {
      :channel => "Search",
      :pageName => "Search Results",
      :keywords => priority_map[:keywords],
      :filter_terms => mapper_context.filter_terms
    }
  end
end