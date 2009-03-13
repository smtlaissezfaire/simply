module Simply
  module Version
    unless defined?(Simply::VERSION)
      MAJOR   = 0
      MINOR   = 1
      TINY    = 0
      VERSION = "#{MAJOR}.#{MINOR}.#{TINY}"
    end
  end
end