
module Diane
  class Recorder
    def initialize(message, opts)
      @message  = escape(message)
      @user = slug(opts.fetch('user', USER))

      record
    end

    def record
      if File.exist? DIFILE
        File.open(DIFILE, 'a') { |f| f.puts("#{@user},#{@message},#{TIME}") }
      else
        File.open(DIFILE, 'a') do |f|
          f.puts('user,message,time')
          f.puts("#{@user},#{@message},#{TIME}")
        end
      end
      puts "✓".green
    rescue => e
      abort 'Broken'.magenta + "#{e}"
    end

    def slug(s)
      abort 'User is nil. Fuck off.'.magenta if s.nil?
      s.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def escape(s)
      abort 'Message is Nil. Fuck off.'.magenta if s.nil?
      "\"#{s.gsub('"','\\"')}\""
    end
  end
end
