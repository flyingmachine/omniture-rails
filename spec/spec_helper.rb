$LOAD_PATH.unshift(File.dirname(__FILE__))

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'omniture-rails'
require 'spec'
require 'spec/autorun'

FIXTURE_DIRECTORY = File.join(File.dirname(__FILE__), 'fixtures')
OmnitureRails.config.sc_directory = FIXTURE_DIRECTORY

Spec::Runner.configure do |config|
end


class Context
  def keywords
    "juice mirror"
  end
  def filter_terms
    "cat shakespeare"
  end
end