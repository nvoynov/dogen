require_relative '../spec_helper'

describe DSLReader do

  class SpecReader < DSLReader
    def self.read(code)
      dsl = new("Unknown", '')
      dsl.read(code)
      dsl.dom
    end
  end

  describe 'handling scipt errors' do
    let(:dsl_source) { 'spec.dogen' }

    let(:correct) {
      <<~EOF
        name 'Users'
        type :user, errm: '', spec: 'v.is_a?'
      EOF
    }

    it 'must read correct dsl' do
      model = SpecReader.read(correct)
      assert_instance_of Domain, model

      SpecTemp.() do
        File.write(dsl_source, correct)
        model = SpecReader.(dsl_source)
        assert_instance_of Domain, model
      end
    end

    let(:argerror) {
      <<~EOF
        name 'Users'
        type :user, errm: 'user', spec: ''
      EOF
    }

    it 'must raise DSL::Error rescued ArgumentError' do
      err = assert_raises(DSL::Error) { SpecReader.read(argerror) }
      assert_match %r{must be String stands for Proc}, err.message

      SpecTemp.() do
        File.write(dsl_source, argerror)
        err = assert_raises(DSL::Error) { SpecReader.(dsl_source) }
        assert_match %r{must be String stands for Proc}, err.message
      end
    end


    let(:read_error) {
      "undefined local variable or method '%s', line: %i"
    }

    let(:undefined1) {
      <<~EOF
        name 'spec'
        spec undefined
      EOF
    }

    let(:undefined2) {
      <<~EOF
        name 'spec'
        spec
      EOF
    }

    it '#read must report undefined' do
      err = assert_raises(DSL::Error) { SpecReader.read(undefined1) }
      assert_match read_error % ['undefined', 1], err.message

      err = assert_raises(DSL::Error) { SpecReader.read(undefined2) }
      assert_match read_error % ['spec', 1], err.message

      SpecTemp.() do
        File.write(dsl_source, undefined1)
        err = assert_raises(DSL::Error) { SpecReader.(dsl_source) }
        assert_match read_error % ['undefined', 1], err.message

        File.write(dsl_source, undefined2)
        err = assert_raises(DSL::Error) { SpecReader.(dsl_source) }
        assert_match read_error % ['spec', 1], err.message
      end
    end
  end

end
