
module Diane
  class Recorder
    def initialize(message, opts)
      @message  = escape(message)
      record
    end

    def record
      if File.exist? DIFILE
        File.open(DIFILE, 'a') { |f| f.puts("#{USER},#{@message},#{TIME}") }
      else
        File.open(DIFILE, 'a') do |f|
          f.puts('user,message,time')
          f.puts("#{USER},#{@message},#{TIME}")
        end
      end
      puts "✓".green
    rescue => e
      abort "Broken".magenta + "#{e}"
    end

    def escape(s)
      abort "Message is Nil. Fuck off.".magenta if s.nil?
      "\"#{s.gsub('"','\\"')}\""
    end
  end
end
