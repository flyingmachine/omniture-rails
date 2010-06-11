# add application.sc to all sc files
# store various sc trees in hash
# before filter
#   - params
#   - priority_map
$LOAD_PATH << File.dirname(__FILE__)

require File.join(File.dirname(__FILE__), '..', 'lib', 'omniture-rails')
require 'action_controller_extension'

%w{ views }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end 

OmnitureRails.config.sc_directory = File.join(RAILS_ROOT, "app", "omniture")
OMNITURE_TREES = Dir[File.join(OmnitureRails.config.sc_directory, '*.sc')].inject({}) do |hash, filename|
  hash[filename[0..-4].to_sym] = OmnitureRails::Parser.new(File.join(OmnitureRails.config.sc_directory, filename)).to_tree
  hash
end