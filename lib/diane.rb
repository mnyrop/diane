require 'date'

require 'diane/version'
require 'diane/player'
require 'diane/recorder'

module Diane
  DIFILE  = './DIANE'
  USER    = `git config user.name`.strip
  TIME    = DateTime.now.strftime("%d/%m/%Y %H:%M")
end
