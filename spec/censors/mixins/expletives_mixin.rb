shared_examples_for :a_censor_for_expletives do

  it_should_include CensoredWords::Expletives
  it_should_censor_words_such_as 'shit'

end