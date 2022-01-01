require_relative 'version'

module Dogen
  module CLI
    extend self

    def sample
      # guard_stderr do
        puts "Dogen: copying $ample domain.."
        unless Dir.exist?(DOMDIR)
          Dir.mkdir(DOMDIR)
          puts "  created #{DOMDIR}"
        end
        sample = File.join(Dogen.root, "lib/erb/#{DOMSRC}")
        FileUtils.cp sample, sample_name
      # end
    end

    def dogen(model)
      guard_stderr do
        puts "load #{model}.."
        domain = load(model)
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
    end

    def sample_name
      File.join(DOMDIR, DOMSRC)
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
