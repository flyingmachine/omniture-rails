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
  
  it "should test all groups in a selector" do
    tree = OmnitureRails::Parser.new(File.read(File.join(OmnitureRails.config.sc_directory, 'selectors_with_groups.sc'))).to_tree
    
    input_group_1 = {
      :action => "show",
      :filter => { :tags => "cat, shakespeare"}
    }
    
    input_group_2 = {
      :action => "new",
      :filter => { :tags => "cat, shakespeare"}
    }
    
    priority_map = {}
    
    mapper_context = Context.new
    OmnitureRails::Applier.new(input_group_1, tree, priority_map, mapper_context).result.should == {:filter => "filtered!"}
    OmnitureRails::Applier.new(input_group_2, tree, priority_map, mapper_context).result.should == {:filter => "filtered!"}
  end
end