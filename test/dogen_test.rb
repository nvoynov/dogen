# frozen_string_literal: true

require_relative 'spec_helper'

describe Dogen do
  it 'must have a version number' do
    refute_nil ::Dogen::VERSION
  end

  it 'must respond to :root' do
    assert_respond_to :root, Dogen
  end
end
