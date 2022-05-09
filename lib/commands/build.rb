require_rel '../'

module Dotfiles
  class Build
    include Helpers

    def initialize(opts = {})
      @theme = Theme.new(opts[:theme])
      @profile = Profile.new
    end

    def run
      builder_paths.each do |path|
        @templates_path = templates_path(path)
        @files_path = files_path(path)

        eval(File.read(path), binding)
      end
    end

    def builder_paths
      Dir[File.join(__dir__, '..', '..', 'plans', '**', 'builder.rb')]
    end

    private

    def templates_path(path)
      File.join(File.dirname(path), 'templates')
    end

    def files_path(path)
      File.join(File.dirname(path), 'files')
    end
  end
end
