begin
  require 'rubygems'
rescue LoadError
end
require 'fileutils'

PATH = File.dirname __FILE__

task :install => 'install:all'
task :update  => 'update:all'

task :default => :update

namespace :install do
  desc "Intialize git submodules"
  task :submodules do
    puts "Installing submodules..."
    system("cd #{PATH}; git submodule init; git submodule update")
  end

  desc "Install dotfiles to user home directory (~/)"
  task :dotfiles do
    puts "Installing dotfiles..."
    dotfiles = Dir.entries("#{PATH}/dotfiles")-['.','..']
    puts "Backing up current files to ~/<FILE>.old."
    dotfiles.each do |dotfile|
      sys_loc = File.join(File.expand_path("~"), dotfile)
      FileUtils.copy sys_loc, "#{sys_loc}.old"
      install "dotfiles/#{dotfile}", sys_loc
    end
  end

  task :all => [:submodules, :dotfiles]
end

namespace :update do
  desc "Update git submodules"
  task :submodules do
    puts "Updating submodules..."
    system("cd #{PATH}; git submodule init; git submodule update")
  end

  desc "Update emacs.d repository"
  task :git do
    puts "Updating emacs.d repository..."
    system("cd #{PATH}; git pull")
  end

  task :all => [:submodules, :git]
end
