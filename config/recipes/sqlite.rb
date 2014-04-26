set_default(:sqlite_database) { "#{application}_production.sqlite3" }

namespace :sqlite do
  desc "Generate the database.yml configuration file."
  task :setup, :roles => :app do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/db"
    template "sqlite.yml.erb", "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "sqlite:setup"

  desc "Symlink the database.yml file into latest release"
  task :symlink, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "sqlite:symlink"
end