require 'digest'

module Dogen

  # Branded file is a file with Dogen banner at the beginning of the fiele
  module BrandedFile
    # writes file with streamer
    def write_branded(name, body, model)
      timestamp = Time.now.strftime('%B %e, %Y at %H:%M:%S')
      body_hash = md5(body)
      branded_body = [BANNER % [body_hash, timestamp, model], body].join
      File.write(name, branded_body)
    end

    # tests if file is branded
    def file_branded?(name)
      bann, body = read_branded(name)
      chk0, chk5 = BANNER.lines.then{|l| [l[0], l[5]]}
      ban0, ban5 = bann.lines.then{|l| [l[0], l[5]]}
      (ban0 == chk0) && (ban5 == chk5)
    end

    # test if branded content changed
    def file_changed?(name)
      bann, body = read_branded(name)
      md5 = bann.lines[1].match(%r{MD5: (.*)\Z})[1]
      md5 != md5(body)
    end

    def read_branded(name)
      lines = File.read(name).lines
      banner_size = BANNER.lines.size - 1
      bann = lines[0..banner_size].join
      body = lines[(banner_size + 1)..lines.size].join
      [bann, body]
    end

    def md5(body)
      Digest::MD5.hexdigest(body)
    end

    BANNER = <<~EOF
      # This file created by Dogen domain generator
      # MD5: %s
      # on %s
      # The domain model "%s"
      # --
      # [Dogen](https://github.com/nvoynov/dogen)
      #

    EOF
  end

end
