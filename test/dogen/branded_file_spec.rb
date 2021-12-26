require_relative '../spec_helper'

class DogenBranded
  include Dogen::BrandedFile

  def initialize(model)
    @model = model
  end

  def write(name, body)
    write_branded(name, body, @model)
  end
end

describe DogenBranded do

  let(:dogname) { 'dogen.rb' }
  let(:branded) { DogenBranded.new('Dogen') }
  let(:content) { 'some branded content' }
  let(:another) { 'another content' }

  it 'must take banner into account' do
    Sandbox.() do
      branded.write(dogname, content)
      assert File.exist? dogname
      assert branded.file_branded?(dogname)
      assert branded.eql_branded?(dogname, content)
      refute branded.eql_branded?(dogname, another)
    end
  end
end
