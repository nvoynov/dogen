require_relative 'version'

module Dogen
  module CLI
    extend self

    def sample
      guard_stderr do
        puts "Dogen: copying $ample domain.."
        unless Dir.exist?(DOMDIR)
          Dir.mkdir(DOMDIR)
          puts "  created #{DOMDIR}"
        end
        sample = File.join(Dogen.root, "lib/erb/#{DOMSRC}")
        FileUtils.cp sample, File.join(DOMDIR, DOMSRC)
      end
    end

    def dogen(model, dir)
      guard_stderr do
        domain = load(model)
        dir = sanitize(domain.name) unless dir
        puts "Dogen: generate skeleton for '#{domain.name}'.."
        unless Dir.exist?(dir)
          Dir.mkdir(dir)
          puts "  created #{dir}"
        end
        log = Generator.(domain, dir)
        log.each{|l| puts "  created #{l}"}
      end
    end

    private

    def sanitize(str)
      str.downcase.strip.gsub(/\s{1,}/, '_')
    end

    def guard_stderr
      yield
    rescue StandardError => e
      puts e.message
      puts BANNER
    end

    def load(name)
      code = File.read(name)
      DSL.build {|dsl| dsl.instance_eval code }
    end

    DOMSRC = 'demo_domain.dogen'
    DOMDIR = 'model'
    BANNER = <<~EOF
      -= Dogen v#{Dogen::VERSION} =- is a domain skeleton generator
      For more information visit https://github.com/nvoynov/dogen

      Quickstart
      1. add 'gem "dogen"' to your Gemfile
      2. run 'dogen $ample'
      3. run 'dogen model/sample.rb'

      COMMANDS:
        $ dogen DOMAIN [SKELETON]
          Creates the DOMAIN in the SKELETON directory

        $ dogen $ample
          Imports sample model into ./model/sample.rb
    EOF
  end
end
