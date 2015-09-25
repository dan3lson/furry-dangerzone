module WordsHelper
  def top_three_entries_for(word, attribute)
    word.send(attribute).split(";").take(3)
  end
end
