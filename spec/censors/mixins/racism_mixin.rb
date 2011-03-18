shared_examples_for :a_censor_for_racism do

  it_should_include CensoredWords::Racism
  it_should_censor_words_such_as 'nigger'

end