# frozen_string_literal: true

require 'diane/player'
require 'diane/recorder'

# Umbrella module for Diane player/recorder
module Diane
  DIFILE  = "#{`pwd`.strip}/DIANE" # Location of Diane file
  USER    = `git config user.name`.strip # Git user initiating the recording
end
