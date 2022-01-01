require 'fileutils'
require_relative 'version'
require_relative 'dsl_reader'

module Dogen
  module CLI
    extend self

    def sample
      puts "Dogen: copying $ample domain.."
      unless Dir.exist?(DOMDIR)
        Dir.mkdir(DOMDIR)
        puts "  created #{DOMDIR}"
      end
      sample = File.join(Dogen.root, "lib/erb/#{DOMSRC}")
      FileUtils.cp sample, sample_name
    end

    def dogen(model)
      puts "load #{model}.."
      domain = DSLReader.(model)
      home = Home.new(domain.name)
      unless Dir.exist?(home.base)
        puts "create home #{home.base}.."
        Dir.mkdir(home.base)
      end
      puts "Dogen generates skeleton in '#{home.base}'.."
      Dir.chdir(home.base) do
        log = Generator.(domain, home.base)
        log.each{|l| puts "  created #{l}"}
      end
    end

    def sample_name
      File.join(DOMDIR, DOMSRC)
    end

    private

    def sanitize(str)
      str.downcase.strip.gsub(/\s{1,}/, '_')
    end

    DOMSRC = 'sample.dogen'
    DOMDIR = 'model'
    BANNER = <<~EOF
      -= Dogen v#{Dogen::VERSION} =- is a domain skeleton generator
      For more information visit https://github.com/nvoynov/dogen

      Quickstart
      1. $ gem install  dogen
      2. $ dogen $ample'
      3. $ dogen model/sample.dogen'

      COMMANDS:
        $ dogen DOMAIN [SKELETON]
          Creates the DOMAIN in the SKELETON directory

        $ dogen $ample
          Imports sample model into ./model/sample.dogen
    EOF
  end
end
