module CommentsHelper
  def redo_comment_options(word)
    [
      "Just repeating the word doesn't make this pass. Please describe in complete sentences how you experienced the word \'#{word}\' in your life.",
      "Don't just repeat the words; please read the directions for this activity and answer it correctly.",
      "Do not write random words or letters. Please read the directions for this activity and answer it correctly.",
      "Instead of writing what letters are in both words, create a short story, poem, song, etc. that includes both words."
    ]
  end
end
