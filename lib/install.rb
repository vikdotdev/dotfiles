require 'tty-prompt'

class Install
  attr_reader :host, :user, :variant

  def initialize(host, user, variant)
    @host = host
    @user = user
    @variant = variant
  end

  def run
    cmd = <<~EOS
      ANSIBLE_STDOUT_CALLBACK=yaml \
      ansible-playbook -e '#{inline_variables}' \
      #{inline_host_options} \
      #{playbook_path}
    EOS

    puts "Running command - #{cmd}"
    system(cmd) if TTY::Prompt.new.yes?('Proceed?')
  end

  def inline_host_options
    case host
    when :localhost then '-K'
    else "-i '#{host},' -Kk"
    end
  end

  def inline_variables
    profile = Profile.new
    variables = {
      target_host: host == :localhost ? host : :all,
      target_user: user,
      profile: profile.number,
      variant: variant
    }

    variables.map { |key, value| "#{key}=#{value}" }.join(' ')
  end

  def playbook_path
    File.expand_path(File.join(__dir__, '..', 'playbooks', 'main.yml'))
  end
end
