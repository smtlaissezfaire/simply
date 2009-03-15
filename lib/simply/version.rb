require "yaml"

module Simply
  module Version
    unless defined?(Simply::VERSION)
      version_info = YAML.load(File.read(File.dirname(__FILE__) + "/../../VERSION.yml"))
      
      MAJOR   = version_info[:major]
      MINOR   = version_info[:minor]
      TINY    = version_info[:patch]
      VERSION = "#{MAJOR}.#{MINOR}.#{TINY}"
    end
  end
end
