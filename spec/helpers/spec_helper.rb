lib_path = File.join(File.dirname(__FILE__), %w{.. .. lib})

require File.join(lib_path, 'censor')

Dir[File.join(lib_path, %w{censors ** *.rb})].each do |file|
  require file
end
