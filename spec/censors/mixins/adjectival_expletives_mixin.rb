shared_examples_for :a_censor_for_adjectival_expletives do

  it_should_include CensoredWords::AdjectivalExpletives
  it_should_censor_words_such_as 'pissing'

end