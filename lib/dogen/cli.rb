require 'cleon'
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
        FileUtils.cp sample, sample_name
      end
    end

    def dogen(model, dir)
      guard_stderr do
        domain = load(model)
        dir = sanitize(domain.name) unless dir
        puts "Dogen: generate skeleton for '#{domain.name}'.."
        prepare_skeleton(dir)
        log = Generator.(domain, dir)
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

    def prepare_skeleton(dir)
      puts "Preparing skeleton directory..."

      dirs = <<~EOF.lines.map(&:strip)
        #{dir}
        #{dir}/lib
        #{dir}/lib/#{dir}
        #{dir}/test
      EOF

      srcs = <<~EOF.lines.map(&:strip)
        #{dir}/lib/#{dir}/version.rb
        #{dir}/lib/#{dir}.rb
        #{dir}/#{dir}.gemspec
      EOF

      dirs.each do |d|
        unless Dir.exist?(d)
          Dir.mkdir(d)
          puts "  created #{d}"
        end
      end

      srcs.each do |src|
        unless File.exist?(src)
          File.write(src, '')
          puts "  created #{src}"
        end
      end
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
