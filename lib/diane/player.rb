require 'csv'
require 'colorize'

module Diane
  # Reconstructs and plays back recordings
  class Player
    attr_reader :recordings, :user

    def initialize(opts)
      @num        = opts.fetch(:num, 1)
      @inorder    = opts.fetch(:inorder, false)
      @user       = opts.fetch(:user, USER)
      @everyone   = opts.fetch(:everyone, false)
      @all        = opts.fetch(:all, false)
      @recordings = query(all_recordings)
    end

    # Returns hash array of all
    # recordings in DIANE file
    def all_recordings
      opts = {
        headers: true,
        header_converters: :symbol,
        encoding: 'utf-8'
      }
      CSV.read(DIFILE, opts).map(&:to_hash)
    end

    # Generates a subset of recordings
    # using command options (number, user, order)
    def query(recordings)
      @num += 1 if @num.zero?
      recordings.select! { |r| r[:user] == @user } unless @everyone
      limit = @all ? recordings.length : [@num, recordings.length].min
      recordings.reverse! unless @inorder
      recordings.take(limit)
    end

    # generates shell message describing
    # the recordings returned by query
    def preface
      position  = @inorder ? 'first' : 'last'
      scope     = @user == USER ? 'your' : "#{@user}'s"
      preface = if @recordings.length == 1
                  %(Here's the #{position} of #{scope} recordings:\n)
                else
                  %(Here's the #{position} #{@recordings.length}
                    of #{scope} recordings:\n)
                end
      preface.green
    end

    # returns and puts formatted recordings
    # returned by query
    def play
      abort %(None from #{@user}. Fuck off.).magenta if @recordings.empty?
      stdout = preface
      @recordings.each do |r|
        stdout += "\n#{r[:time]} : ".cyan + "@#{r[:user]}".yellow
        stdout += "\n#{r[:message]}\n\n"
      end
      puts stdout
      stdout
    end
  end
end
