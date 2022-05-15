require 'fileutils'
require 'erb'
require 'tty-prompt'

module Ansible
  class Install
    attr_reader :host, :user

    def initialize(host, user)
      @host = host
      @user = user
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
      variables = {
        target_host: host == :localhost ? host : :all,
        target_user: user
      }
      profile = Profile.new
      variables.merge!(profile.config.each_with_object({}) do |(name, number), memo|
        memo.merge!("profile_#{number}".to_sym => (profile.hostname == name))
        memo
      end)

      variables.map { |key, value| "#{key}=#{value}" }.join(' ')
    end

    def playbook_path
      File.expand_path(File.join(__dir__, '..', 'playbooks', 'main.yml'))
    end
  end

  class PostInstall
  end
end

