require_relative 'spec_helper'
include Dogen

describe 'dry-run exe/dogen' do
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
        _, _ = capture_subprocess_io { system "dogen $ample" }
        assert File.exist?(CLI.sample_name)
      end
    end
  end

  describe 'dogen <model>' do
    it 'must copy sample.rb file into model dir' do
      SpecGem.('users') do
        source = CLI.sample_name
        _, _ = capture_subprocess_io {
          system "dogen $ample"
          system "dogen #{source} .."
        }
      end
    end
  end
end