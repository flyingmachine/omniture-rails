require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "OmnitureRails::Mapper" do
  before :all do
    OmnitureRails::Mapper.define_map do
      map :controller => "searches", :to => {
        :pageName => "Search"
      }
      
      map :controller => "searches" do
        map :action => "show", :to => {:pageName => "SearchResults"}
      end
      
      map :controller => "profiles" do
        map :action => "show" do
          map :current, {
            :pageName => "MyProfile"
          }
          map "MyProfile"
        end
      end
      
    end
  end
  
  it "should associate a hash with the first specification that matches" do
    OmnitureRails::Mapper.define_map do
      map :controller => "searches", :to => {
        :pageName => "Search"
      }
      
      map :controller => "searches" do
        map :action => "show", :to => {:pageName => "SearchResults"}
      end
    end
    
    OmnitureRails::Mapper.map({:controller => "searches", :action => "show"}).should == {:pageName => "Search"}
  end
end