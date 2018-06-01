require 'csv'
require 'colorize'

module Diane
  class Player
    def initialize(num, opts)
      @num = num
      @inorder = opts.fetch('inorder', false)
      @everyone = opts.fetch('everyone', false)
      @all = opts.fetch('all', false)
      @recordings = recordings

      play
    end

    def recordings
      r = CSV.read(DIFILE, { headers: true }).map(&:to_hash)
      r.select!{ |d| d['user'] == USER } unless @everyone
      limit = @all ? r.length : [@num, r.length].min
      r.reverse! unless @inorder
      r.take(limit)
    end

    def preface
      position  = @inorder ? 'first' : 'last'
      scope     = @everyone ? "everyone's" : 'your'
      if @recordings.length == 1
        preface = "\nHere's the #{position} of #{scope} recordings:"
      else
        preface = "\nHere's the #{position} #{@recordings.length} of #{scope} recordings:"
      end
      preface.green
    end

    def play
      if @recordings.empty?
        puts "\nFuck off.".magenta
      else
        puts preface
        recordings.each do |r|
          puts "\n#{r['time']} : ".cyan + "@#{r['user']}".yellow
          puts "#{r['message']}"
        end
      end
    end
  end
end
