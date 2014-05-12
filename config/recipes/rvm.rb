set_default(:ruby_version){"2.0.0-p0"}
set_default(:rvm_ruby_string){"#{ruby_version}@#{application}"}
set_default(:rvm_type){:user}

require "rvm/capistrano"

before "deploy:install", "rvm:install_rvm"
before "deploy:install", "rvm:install_ruby"
after "deploy:update_code", "rvm:trust_rvmrc"

desc "trust project .rvmrc automatically"
namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end
