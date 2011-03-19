lib_path = File.join(File.dirname(__FILE__), %w{.. .. lib})

Dir[File.join(lib_path, %w{** *.rb})].each do |file|
  require file
end

Dir[File.join(File.dirname(__FILE__), %w{.. ** mixins *.rb})].each do |file|
  require file
end

def fixture_dictionary
  File.join(File.dirname(__FILE__), '..', 'fixtures', 'test_dictionary.yml')
end

def safe_word_files
  Dir.glob(File.join(File.dirname(__FILE__), '..', 'fixtures', 'safe_word_lists', '*.txt'))
end