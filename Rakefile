require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/censor'

Hoe.plugin :newgem
# Hoe.plugin :website
# Hoe.plugin :cucumberfeatures

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'censor' do
  self.developer 'Stephen Hardisty', 'moowahaha@hotmail.com'

  self.rubyforge_name = self.name

  self.extra_deps = [
      ['amatch','>= 0.2.5'],
      ['yaml','>= 0'],
      ['trollop', '>= 1.16.2']
  ]
end

Dir['tasks/**/*.rake'].each { |t| load t }

Dir[File.join(File.dirname(__FILE__), %w{lib ** *.rb})].each do |file|
  require file
end
