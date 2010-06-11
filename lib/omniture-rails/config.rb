module OmnitureRails
  class Config
    include Singleton
    attr_accessor :sc_directory, :prop_map, :tracking_account
  end
end