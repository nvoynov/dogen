require_relative '../spec_helper'
include Dogen

describe Render do

  describe 'Render.(obj, erb)' do
    it 'must render' do
      erb = '<%= @object.to_s %>'
      assert_equal ['1'], Render.(1, erb)
      assert_equal %w(1 2 3), Render.([1, 2, 3], erb)
    end
  end

end
