module Dogen

  # Branded file is a file with Dogen banner at the beginning of the fiele
  module BrandedFile
    # writes file with streamer
    def write_branded(name, body, model)
      timestamp = Time.now.strftime('on %B %e, %Y at %H:%M:%S')
      branded_body = [BANNER % [timestamp, model], body].join(?\n)
      File.write(name, branded_body)
    end

    # tests if file is branded
    def file_branded?(name)
      body = File.read(name)
      body_branded?(body)
    end

    def body_branded?(body)
      s0, s4 = BANNER.lines.then{|l| [l[0], l[4]]}
      body.lines.then do |l|
        return false unless l[0] == s0
        l[4] == s4
      end
    end

    # tests for content equals without streamer excluding streamer
    def eql_branded?(name, body)
      branded = File.read(name)
      return false unless body_branded?(branded)
      clean = String.new(branded).lines
      BANNER.lines.size.times{|i| clean.shift}
      body.eql?(clean.join .strip)
    end

    BANNER = <<~EOF
      # This file created by Dogen domain generator
      # %s
      # The domain model "%s"
      # --
      # [Dogen](https://github.com/nvoynov/dogen)
      #
    EOF
  end

end
