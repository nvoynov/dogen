module Dogen

  # Helper class to create a new home for dogen skeleton
  class Home
    # @param home [String] folder for new dogen gnerated model
    def initialize(home)
      @home = home
    end

    # creates folders structure
    def furnish
      log = []
      fur = dirs.filter{|dir| !Dir.exist?(dir)}
      log << 'Cloning Cleon might help this skeleton' unless fur.empty?
      fur.each do |dir|
        Dir.mkdir(dir)
        log << dir
      end
      log
    end

    # check if folders structure in order
    def furnished?
      dirs.all?{|dir| Dir.exist?(dir)}
    end

    def base
      @base ||= begin
        basename = File.basename(@home)
        basename.downcase.strip.gsub(/\s{1,}/, '_')
      end
    end

    def dirs
      [
        "lib",
        "lib/#{base}",
        "lib/#{base}/services",
        "lib/#{base}/entities",
        "test",
        "test/#{base}",
        "test/#{base}/services",
        "test/#{base}/entities"
      ]
    end

  end

end
