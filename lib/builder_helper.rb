require 'fileutils'
require 'erb'

module BuilderHelper
  def render_template(template)
    template_path = File.join(@templates_path, "#{template}.erb")
    ERB.new(File.read(template_path)).result(binding)
  end

  def files(recursive: false)
    glob_path = File.join(@files_path, (recursive ? '**/*' : '*'))

    Dir.glob(File.expand_path(glob_path), File::FNM_DOTMATCH).map do |path|
      next if %w[. ..].include?(File.basename(path)) || File.directory?(path)

      Pathname.new(path).relative_path_from(File.expand_path(@files_path)).to_s
    end.compact
  end

  def templates
    Dir.entries(@templates_path).drop(2).map { |template| template.delete_suffix('.erb') }
  end

  def read_file(filename)
    File.read(File.join(@files_path, filename))
  end

  def chmod(mode, filepath)
    FileUtils.chmod(mode, filepath)
  end

  def ensure_write_file(destination, contents = nil)
    FileUtils.mkdir_p(File.dirname(destination))
    FileUtils.touch(destination)
    File.open(destination, 'w+') { |file| file.write(contents) } if contents
  end

  def home_file(path)
    File.join(Dir.home, Pathname.new(path))
  end

  def ensure_service_running(name)
    system "systemctl enable --now --user #{name}"
  end
end
