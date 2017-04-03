# TODO Update description so it's a regular string without the new line characters
namespace :games do
  desc "Create new games for a total of twelve."
  task :update_descriptions => :environment do
    puts Game.find_by(name: "Speed Spelling").update_attributes(
      description: "Type the target word as fast as you can. See if you can beat your previous record and earn even more Linero each time you type the word."
    )
    puts Game.find_by(name: "Jumbled Letters").update_attributes(
      description: "Type the target word as fast as you can. See if you can beat your previous typing record and earn even more Linero each time you type the word."
    )
    puts Game.find_by(name: "Say It Right").update_attributes(
      description: "Hear the pronunciation for the target word and say it right yourself."
    )
    puts Game.find_by(name: "Decisions, Decisions").update_attributes(
      description: "You have the power to make important choices in this Level - be careful with the decisions you make."
    )
    puts Game.find_by(name: "Examples/Non-Examples").update_attributes(
      description: "Figure out whether the scenarios are an example - or not! - of the target word."
    )
    puts Game.find_by(name: "Syns vs Ants").update_attributes(
      description: "Match the synonym and antonym pairs for the target word."
    )
    puts Game.find_by(name: "Jeopardy").update_attributes(
      description: "Earn lots of Linero by picking a category and amount and then answering the question correctly. Of course, if you answer incorrectly, then you'll lose Linero."
    )
    puts Game.find_by(name: "Match 'Em All").update_attributes(
      description: "puts Game and description coming soon."
    )
    puts Game.find_by(name: "Sentence Stems").update_attributes(
      description: "Meet us halfway by finishing the given sentences for the target word."
    )
    puts Game.find_by(name: "Word Relationships").update_attributes(
      description: "Some words can be more alike than you think! Determine how the given words can relate to each other."
    )
    puts Game.find_by(name: "Leksi Tale").update_attributes(
      description: "Create a short story, poem, rap, etc. with at least three of your words. This can be real or fake so have fun with it."
    )
    puts Game.find_by(name: "Describe Me, Describe Me Not").update_attributes(
      description: "Hmmm...would you want to be described by the target word?"
    )
    puts Game.find_by(name: "In My Life").update_attributes(
      description: "Did you see or hear any of your words in the media, magazines, TV, social media, etc.? If so, record it here and earn some serious Linero. For every three In My Lifes that you save, you\'ll Level Up!"
    )
  end
end
