class Censor
  class MyName
    def replace text
      text.gsub(/hardisty/i, '********')
    end
  end
end