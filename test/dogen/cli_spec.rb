require_relative '../spec_helper'
include Dogen

describe CLI do
  describe 'dry-run dogen(model, dir)' do
    it 'must generate for sample' do
      SpecTemp.() do
        _, _ = capture_io do
          CLI.sample
          CLI.dogen(CLI.sample_name, nil)
        end
      end
    end
  end
end
