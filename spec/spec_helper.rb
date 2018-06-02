require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'diane'
require_relative 'utilities'

# toggle for spec verbosity
QUIET = true
