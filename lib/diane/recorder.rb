require 'csv'

module Diane
  # Records messages and metadata
  class Recorder
    attr_reader :user

    def initialize(message, opts)
      abort 'Message is Nil. Fuck off.'.magenta if message.nil?
      @message  = message
      @user     = slug(opts.fetch(:user, USER))
      @time     = Time.now.asctime
    end

    # generates new recording as csv row
    # to new or existing DIANE file
    def record
      if File.exist? DIFILE
        CSV.open(DIFILE, 'a') { |csv| csv << [@user, @message, @time] }
      else
        CSV.open(DIFILE, 'a') do |csv|
          csv << %w[user message time]
          csv << [@user, @message, @time]
        end
      end
      puts '✓'.green
    rescue StandardError => e
      abort 'Broken'.magenta + e
    end

    # normalizes and slugifies
    # recording user handle
    def slug(user)
      abort 'User is nil. Fuck off.'.magenta if user.nil?
      user.downcase.strip.tr(' ', '_').gsub(/[^\w-]/, '')
    end
  end
end
