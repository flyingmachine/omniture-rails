require 'singleton'
require 'omniture-rails/config'
require 'omniture-rails/node'
require 'omniture-rails/parser'
require 'omniture-rails/value'

module OmnitureRails
  class << self
    def config
      OmnitureRails::Config.instance
    end
  end
end