require_relative '../spec_helper'
require_relative 'shared_domain'
include Dogen

class FileBox
  def self.call
    Dir.mktmpdir(['dogen']) do |dir|
      Dir.chdir(dir) { yield }
    end
  end
end

describe Gen do

  let(:dom) {
    DSL.build do
      name 'Spec'
      desc 'Spec Domain'

      type :string, errm: 'not a String', spec: 'v.is_a?(String)'
      type :integer, errm: 'not an Integer', spec: 'v.is_a?(Integer)'

      entity :one do
        atrb :str, type: :string
        atrb :int, type: :integer
      end

      service :call do
        param :s, type: :string
        param :i, type: :integer
        result :r1, type: :integer
      end
    end
  }

  describe 'Gen.(dom)' do
    it 'must revel' do
      Dir.chdir("test/users") do
        Gen.(dom)
      end
    end
  end

end
