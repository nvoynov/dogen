require_relative 'spec_helper'

describe 'exe/dogen' do
  let(:banner) { /-= Dogen/ }

  describe 'banner' do
    it 'must print banner when exec without arguments' do
      out, _ = capture_subprocess_io { system "ruby exe/dogen" }
      assert_match banner, out
    end
  end

  describe '$ample' do
    it 'must copy sample.rb file into model dir' do
      SpecTemp.() do
        out, err = capture_subprocess_io { system "ruby exe/dogen $ample" }
        puts out
        puts err        
      end
    end
  end
end
