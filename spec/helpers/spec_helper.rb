lib_path = File.join(File.dirname(__FILE__), %w{.. .. lib})

Dir[File.join(lib_path, %w{censors ** *.rb})].each do |file|
  require file
end
