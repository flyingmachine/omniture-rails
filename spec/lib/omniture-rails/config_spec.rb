require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "OmnitureRails::Config" do
  before :each do
    OmnitureRails.config.sc_directory = FIXTURE_DIRECTORY
    OmnitureRails.config.prop_map = {}
    OmnitureRails.config.tracking_account = nil
    OmnitureRails.config.visitor_namespace = nil
    OmnitureRails.config.noscript_img_src = nil
  end
  
  after :all do
    OmnitureRails.config.sc_directory = FIXTURE_DIRECTORY
  end
  
  it "should set the config from a yaml filename" do
    OmnitureRails.config.set(File.expand_path(File.join(FIXTURE_DIRECTORY, 'config.yml')))
    OmnitureRails.config.sc_directory.should == "dir"
    OmnitureRails.config.prop_map.should == {:keywords => :chassis}
    OmnitureRails.config.tracking_account.should == "dev"
    OmnitureRails.config.visitor_namespace.should == "namespace"
    OmnitureRails.config.noscript_img_src.should == "http://127.0.0.1"
  end
  
  it "should set the config from a file" do
    OmnitureRails.config.set(File.open(File.expand_path(File.join(FIXTURE_DIRECTORY, 'config.yml'))))
    OmnitureRails.config.sc_directory.should == "dir"
    OmnitureRails.config.prop_map.should == {:keywords => :chassis}
    OmnitureRails.config.tracking_account.should == "dev"
    OmnitureRails.config.visitor_namespace.should == "namespace"
    OmnitureRails.config.noscript_img_src.should == "http://127.0.0.1"
  end
  
  it "should set the config from a hash" do
    OmnitureRails.config.set({
      "sc_directory"      => "a",
      "prop_map" => {:k   => :v},
      "tracking_account"  => "b",
      "visitor_namespace" => "c",
      "noscript_img_src"  => "d"
    })
    OmnitureRails.config.sc_directory.should == "a"
    OmnitureRails.config.prop_map.should == {:k => :v}
    OmnitureRails.config.tracking_account.should == "b"
    OmnitureRails.config.visitor_namespace.should == "c"
    OmnitureRails.config.noscript_img_src.should == "d"
  end
end