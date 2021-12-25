require_relative '../spec_helper'

describe ArGuard do

  let(:gname) { 'string[5]' }
  let(:gerrm) { 'must be String[5]' }
  let(:guard) {
    ArGuard.new(gname, gerrm,
      Proc.new { |v| v.is_a?(String) && v.length < 6 })
  }

  it 'must return valid arg' do
    %w(a ab abc abcd abcde).each do |arg|
      assert_equal arg, guard.(arg)
    end
  end

  it 'must raise ArgumentError' do
    [nil, 25, 'toolong'].each do |arg|
      err = assert_raises(ArgumentError) { guard.(arg) }
      rex = Regexp.escape ":#{gname} #{gerrm}"
      assert_match %r{#{rex}}, err.message
    end

    err = assert_raises(ArgumentError) { guard.(25, 'arg') }
    rex = Regexp.escape ":arg #{gerrm}"
    assert_match %r{#{rex}}, err.message

    err = assert_raises(ArgumentError) { guard.(25, 'arg', 'must be Arg') }
    assert_match %r{:arg must be Arg}, err.message
  end
end
