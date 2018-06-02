require 'simplecov'
SimpleCov.start

require 'csv'
require 'faker'
require 'fileutils'

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'diane'

QUIET = true # toggle for spec verbosity

FileUtils.rm(Diane::DIFILE, force: true)

describe 'diane' do
  before(:all) do
    @recordings     = fake_recordings(20)
    @users          = sort_users(@recordings)
  end
  it 'runs from the command line' do
    expect(`diane --version`).to include('diane 0')
  end
  describe 'diane::recorder' do
    it 'records witout errors' do
      @recordings.each { |r| silence_output { r.record } }
      expect(File).to exist(Diane::DIFILE)
    end
  end
  describe 'diane::player' do
    before(:all) do
      @player         = Diane::Player.new({})
      @user_player    = Diane::Player.new(num: 3, user: @users.first)
      @ea_player      = Diane::Player.new(num: 1, user: 'everyone', all: true)
      @inorder_player = Diane::Player.new(num: 3, user: @users.first, inorder: true)
    end
    it 'builds a player object' do
      expect(@player)
    end
    it 'returns correct results with --user option' do
      expect(@user_player.recordings.all? { |r| r[:user] == @users.first })
    end
    it 'returns correct results with --everyone and --all options' do
      every_all_result_size = @ea_player.recordings.length
      total_size            = @player.all_recordings.length
      expect(every_all_result_size).to eq(total_size)
      expect(every_all_result_size).not_to eq(0)
    end
    it 'returns correct results with --inorder options' do
      first_default_result  = @user_player.recordings.first
      last_inorder_result   = @inorder_player.recordings.last
      expect(first_default_result).to eq(last_inorder_result)
    end
    it 'plays back with expected preface' do
      result = silence_output { @user_player.play }
      expect(result).to include(@users.first)
    end
    it 'plays back when run in the shell' do
      result = `diane playback --user #{@users[2]} --all`
      expect(result).to include(@users[2])
    end
  end
end

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
