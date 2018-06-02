require 'faker'

def fake_recordings(number)
  recordings = []
  number.times do
    message = Faker::TwinPeaks.unique.quote
    opts = { user: Faker::TwinPeaks.character }
    recording = silence_output { Diane::Recorder.new(message, opts) }
    recordings << recording
  end
  recordings
end

def sort_users(recordings)
  recordings.map(&:user).sort_by_frequency.reverse.uniq
end

def silence_output
  if QUIET
    begin
      orig_stderr = $stderr.clone
      orig_stdout = $stdout.clone
      $stderr.reopen File.new('/dev/null', 'w')
      $stdout.reopen File.new('/dev/null', 'w')
      retval = yield
    ensure
      $stdout.reopen orig_stdout
      $stderr.reopen orig_stderr
    end
    retval
  else
    yield
  end
end

module Enumerable
  def sort_by_frequency
    histogram = inject(Hash.new(0)) { |hash, x| hash[x] += 1; hash }
    sort_by { |x| [histogram[x], x] }
  end
end
