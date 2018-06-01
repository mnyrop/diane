require 'csv'
require 'colorize'

module Diane
  class Player
    def initialize(num, opts)
      @num = num
      @inorder = opts.fetch('inorder', false)
      @user = opts.fetch('user', USER)
      @all = opts.fetch('all', false)
      @recordings = recordings

      play
    end

    def recordings
      r = CSV.read(DIFILE, { headers: true }).map(&:to_hash)
      r.select!{ |d| d['user'] == @user } unless @user == 'everyone'
      limit = @all ? r.length : [@num, r.length].min
      r.reverse! unless @inorder
      r.take(limit)
    end

    def preface
      position  = @inorder ? 'first' : 'last'
      scope = @user == USER ? 'your' : "#{@user}'s"
      if @recordings.length == 1
        preface = "\nHere's the #{position} of #{scope} recordings:"
      else
        preface = "\nHere's the #{position} #{@recordings.length} of #{scope} recordings:"
      end
      preface.green
    end

    def play
      if @recordings.empty?
        puts "\nNo recordings from #{@user}. Fuck off.".magenta
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
