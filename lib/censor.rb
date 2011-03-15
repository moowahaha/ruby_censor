class Censor
  VERSION = '0.0.1'

  def replace text
    clean_text = text.dup

    censored_words.sort {|a, b| a.length <=> b.length}.each do |word|
      clean_text.gsub!(/\b#{word}\b/i, '*' * word.length)
    end

    clean_text
  end
end

#http://www.asa.org.uk/Resource-Centre/~/media/Files/ASA/Reports/ASA_Delete_Expletives_Dec_2000.ashx