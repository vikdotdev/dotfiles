require_rel '../'
require_rel '../helpers'

module Dotfiles
  class Build
    include BuilderHelper
    include TmuxHelper
    include VimHelper
    include VifmHelper

    def initialize(opts = {})
      @theme = Theme.new(opts[:theme])
      @profile = Profile.new
      @config = YAML.load_file(File.join(__dir__, '..', '..', 'config.yml'))
      @colors = Color.new(@config)
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
