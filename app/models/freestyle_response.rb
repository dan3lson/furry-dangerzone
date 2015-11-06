class FreestyleResponse < ActiveRecord::Base
  belongs_to :user_word
  belongs_to :user_word_game_level

  validates :input, presence: true
  # validates :user_word_game_level, presence: true
  # validates :focus, presence: true
  # validates :user_word, presence: true

  def self.for(user_word)
    where(user_word_id: user_word.id)
  end

  def self.simplify_backend
    good_frs = []
    bad_frs = []

    all.sort_by { |fr| fr.id }.each_slice(12).each do |batch|
      batch[11].focus = "Sentence Example"
      batch[10].focus = "Sentence Example"
      batch[9].focus = "Sentence Example"

      batch[8].focus = "Definition Map"
      batch[7].focus = "Definition Map"
      batch[6].focus = "Definition Map"

      batch[5].focus = "Word Map"
      batch[4].focus = "Word Map"
      batch[3].focus = "Word Map"

      batch[2].focus = "Semantic Map"
      batch[1].focus = "Semantic Map"
      batch[0].focus = "Semantic Map"

      batch[11].user_word_id = batch[11].user_word_game_level.user_word.id
      batch[10].user_word_id = batch[10].user_word_game_level.user_word.id
      batch[9].user_word_id = batch[9].user_word_game_level.user_word.id

      batch[8].user_word_id = batch[8].user_word_game_level.user_word.id
      batch[7].user_word_id = batch[7].user_word_game_level.user_word.id
      batch[6].user_word_id = batch[6].user_word_game_level.user_word.id

      batch[5].user_word_id = batch[5].user_word_game_level.user_word.id
      batch[4].user_word_id = batch[4].user_word_game_level.user_word.id
      batch[3].user_word_id = batch[3].user_word_game_level.user_word.id

      batch[2].user_word_id = batch[2].user_word_game_level.user_word.id
      batch[1].user_word_id = batch[1].user_word_game_level.user_word.id
      batch[0].user_word_id = batch[0].user_word_game_level.user_word.id

      if batch[11].save
        good_frs << "Success: Freestyle #{batch[11].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[11].id} :'(."
      end
      if batch[10].save
        good_frs << "Success: Freestyle #{batch[10].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[10].id} :'(."
      end
      if batch[9].save
        good_frs << "Success: Freestyle #{batch[9].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[9].id} :'(."
      end

      if batch[8].save
        good_frs << "Success: Freestyle #{batch[8].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[8].id} :'(."
      end
      if batch[7].save
        good_frs << "Success: Freestyle #{batch[7].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[7].id} :'(."
      end
      if batch[6].save
        good_frs << "Success: Freestyle #{batch[6].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[6].id} :'(."
      end

      if batch[5].save
        good_frs << "Success: Freestyle #{batch[5].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[5].id} :'(."
      end
      if batch[4].save
        good_frs << "Success: Freestyle #{batch[4].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[4].id} :'(."
      end
      if batch[3].save
        good_frs << "Success: Freestyle #{batch[3].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[3].id} :'(."
      end

      if batch[2].save
        good_frs << "Success: Freestyle #{batch[2].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[2].id} :'(."
      end
      if batch[1].save
        good_frs << "Success: Freestyle #{batch[1].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[1].id} :'(."
      end
      if batch[0].save
        good_frs << "Success: Freestyle #{batch[0].id} updated."
      else
        bad_frs << "ERROR for Freestyle #{batch[0].id} :'(."
      end
    end

    [good_frs, bad_frs]
  end

  def steps
    # 1) Add new columns and update existing data -> COMPLETE

    # 2) Update creation of FR objects in controllers, etc. -> COMPLETE

    # 3) Simplify user_word/UWGL/backend/tests - yikes! :D!!! -> COMPLETE

    # 4) Backup prod, load locally, and test #simplify_backend methods -> COMPLETE

    # 5) Push and tighten loose ends
      # git push heroku master
      # heroku run rake db:migrate

      # git add .
      # git commit -m "Simplifies freestyle_responses association/backend + overall tracking of games backend by removing UWGLs, and  updates views."
      # git push origin update-freestyle-responses
      # git checkout master
      # -> go to gitHub and merge
      # git pull origin master
      # git push heroku master

      # heroku run rake db:migrate
      # heroku run rails c
      # FreestyleResponse.simplify_backend
      # UserWord.simplify_backend

      # Comment/Uncomment appropriate code related to UWGL, GL, Levels, etc.
  end
end
