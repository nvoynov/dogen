require_relative '../spec_helper'
require_relative 'shared_domain'

# TODO move this code to Rakefile
# TODO also Rakefile full-fledged sandbox based on Users
# This test is using to produce samples for real gen_spec
describe Gen do

  let(:base) { 'test/samples' }
  let(:dirs) { [base, "#{base}/services", "#{base}/entities"] }
  let(:dom) { build_users_domain }

  before do
    dirs.each{|dir| Dir.mkdir(dir) unless Dir.exist?(dir)}
  end

  describe 'Gen.(dom)' do
    it 'must create a set of samples for comparison' do
      Dir.chdir(base) do
        Gen.(dom)
        ruby_code = "require './_dogen'; puts '42'"
        out, err = capture_subprocess_io do
          system "ruby -e \"#{ruby_code}\""
        end
        assert_match /42/, out
      end
    end
  end

end
