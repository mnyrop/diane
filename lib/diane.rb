require 'diane/player'
require 'diane/recorder'

# Umbrella module for Diane player/recorder
module Diane
  DIFILE  = "#{`pwd`.strip}/DIANE".freeze # Location of Diane file
  USER    = `git config user.name`.strip # Git user initiating the recording
  VERSION = '0.0.2'.freeze # Gem version
end
