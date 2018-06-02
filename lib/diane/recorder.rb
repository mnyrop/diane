require 'csv'

module Diane
  # class to record messages
  class Recorder
    attr_reader :user

    def initialize(message, opts)
      abort 'Message is Nil. Fuck off.'.magenta if message.nil?

      @message  = message
      @user     = slug(opts.fetch(:user, USER))
      @time     = Time.now.asctime
    end

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

    def slug(str)
      abort 'User is nil. Fuck off.'.magenta if str.nil?
      str.downcase.strip.tr(' ', '_').gsub(/[^\w-]/, '')
    end
  end
end
