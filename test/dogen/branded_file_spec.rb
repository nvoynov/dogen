require_relative '../spec_helper'

class DogenBranded
  include Dogen::BrandedFile

  def write(name, body)
    write_branded(name, body)
  end
end

describe DogenBranded do

  let(:dogname) { 'dogen.rb' }
  let(:branded) { DogenBranded.new }
  let(:content) { 'some branded content' }
  let(:another) { 'another content' }

  it 'must take banner into account' do
    SpecTemp.() do
      branded.write(dogname, content)
      assert File.exist? dogname
      assert branded.file_branded?(dogname)
      refute branded.file_changed?(dogname)

      bann, body = branded.read_branded(dogname)
      File.write(dogname, [bann, body, 'change'].join)
      assert branded.file_changed?(dogname)
    end
  end
end
