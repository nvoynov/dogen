require 'digest'

module Dogen

  # Branded file is a file with Dogen banner at the beginning of the fiele
  module BrandedFile
    # writes file with streamer
    def write_branded(name, body)
      hash = md5(body)
      brnd = [BANNER % hash, body].join
      File.write(name, brnd)
    end

    # tests if file is branded
    def file_branded?(name)
      bann, _ = read_branded(name)
      chk0, chk1 = BANNER.lines.then{|l| [l[0], l[1]]}
      ban0, ban1 = bann.lines.then{|l| [l[0], l[1]]}
      (ban0 == chk0) && (ban1 == chk1)
    end

    # test if branded content changed
    def file_changed?(name)
      bann, body = read_branded(name)
      md5 = bann.lines[2].match(%r{MD5: (.*)\Z})[1]
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
      # This source created by code generator
      # see: https://github.com/nvoynov/dogen
      # MD5: %s
      #

    EOF
  end

end
