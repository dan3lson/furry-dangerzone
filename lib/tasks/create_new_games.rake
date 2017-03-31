# TODO Update description so it's a regular string without the new line characters
namespace :create do
  desc "Create new games for a total of twelve."
  task :new_games => :environment do
    puts Game.create!(
      name: "Speed Spelling",
      description: "Type the target word as fast as you can. See if you can
      beat your previous record and earn even more Linero each time you
      type the word."
    )
    puts Game.create!(
      name: "Jumbled Letters",
      description: "Type the target word as fast as you can. See if you can
      beat your previous typing record and earn even more Linero each time you
      type the word."
    )
    puts Game.create!(
      name: "Say It Right",
      description: "Hear the pronunciation for the target word and say it right
      yourself."
    )
    puts Game.create!(
      name: "Decisions, Decisions",
      description: "You have the power to make important choices in this Level -
      be careful with the decisions you make."
    )
    puts Game.create!(
      name: "Examples/Non-Examples",
      description: "Figure out whether the scenarios are an example - or not! -
      of the target word."
    )
    puts Game.create!(
      name: "Syns vs Ants",
      description: "Match the synonym and antonym pairs for the target word."
    )
    puts Game.create!(
      name: "Jeopardy",
      description: "Earn lots of Linero by picking a category and amount and
      then answering the question correctly. Of course, if you answer
      incorrectly, then you'll lose Linero."
    )
    puts Game.create!(
      name: "Match 'Em All",
      description: "puts Game and description coming soon."
    )
    puts Game.create!(
      name: "Sentence Stems",
      description: "Meet us halfway by finishing the given
      sentences for the target word."
    )
    puts Game.create!(
      name: "Word Relationships",
      description: "Some words can be more alike than you think! Determine how
      the given words can relate to each other."
    )
    puts Game.create!(
      name: "Leksi Tale",
      description: "Create a short story, poem, rap, etc.
      with at least three of your words. This can be real or fake so
      have fun with it."
    )
    puts Game.create!(
      name: "Describe Me, Describe Me Not",
      description: "Hmmm...would you want to be described by the target word?"
    )
    puts Game.create!(
      name: "In My Life",
      description: "Did you see or hear any of your words in the media,
      magazines, TV, social media, etc.? If so, record it here and
      earn some serious Linero. For every three In My Lifes that you save,
      you\'ll Level Up!"
    )
  end
end
