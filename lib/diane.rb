require 'diane/player'
require 'diane/recorder'

module Diane
  DIFILE  = "#{`pwd`.strip}/DIANE".freeze
  USER    = `git config user.name`.strip
  VERSION = '0.0.2'.freeze
end
