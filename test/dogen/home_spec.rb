require_relative '../spec_helper'

describe Home do

  let(:spec_home) { 'home' }
  let(:output) {
    <<~EOF
      lib
      lib/home
      lib/home/entities
      lib/home/services
      test
      test/home
      test/home/entities
      test/home/services
    EOF
  }

  describe 'furnish' do
    it 'must furnish' do
      SpecTemp.() do
        home = Home.new(spec_home)
        log = nil
        log = home.furnish
        assert home.furnished?
        assert output, log
      end
    end

    it 'must furnish by File.basename' do
      SpecTemp.() do
        home = Home.new(File.join(Dir.pwd, spec_home))
        home.furnish
        assert home.furnished?
      end
    end
  end

  describe '#furnished?' do
    it 'must return false when not furnished' do
      SpecTemp.() do
        home = Home.new(spec_home)
        refute home.furnished?
      end
    end

    it 'must return true when furnished' do
      SpecTemp.() do
        Dir.mkdir(spec_home)
        home = Home.new(spec_home)
        home.furnish
        assert home.furnished?
      end
    end
  end

end
