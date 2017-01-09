class User < ActiveRecord::Base
  has_many :user_words, dependent: :destroy
  has_many :words, through: :user_words
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags
  has_many :user_word_tags, dependent: :destroy
  has_many :word_tags, through: :user_word_tags
  has_many :meaning_alts

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 33 }
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_nil: true,
                    uniqueness: { case_sensitive: false }
  validates :points, presence: true
  validates :num_flashcards_played, presence: true
  validates :first_name, length: { maximum: 50 }
  validates :last_name, length: { maximum: 50 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  before_create { self.username = username.downcase }
  before_create { self.email = email.downcase }

  # TODO: Create test
  def self.set_up_login_data(user)
    datetime_now = DateTime.now
    user.last_login = datetime_now
    user.login_history = ""
    user.login_history += datetime_now.to_s << "|"
    user.num_logins += 1
  end

  def has_email_address?
    !email.nil?
  end

  def has_word?(word)
    !UserWord.find_by(user: self, word: word).nil?
  end

  def has_words?
    words.any?
  end

  def has_tags?
    tags.any?
  end

  def has_user_word_tags?
    user_word_tags.any?
  end

  def has_tag?(tag)
    tags.include?(tag)
  end

  def is_admin?
    role == "admin"
  end

  def is_teacher?
    role == "teacher" || role == "admin"
  end

  def is_admin_or_teacher?
    is_admin? || is_teacher?
  end

  def is_student?
    role == "student" || is_teacher? || is_admin?
  end

  # TODO Create test
  def is_brainiac?
    role == "brainiac" || is_student? || is_admin?
  end

  def is_not_a_student?
    !is_student?
  end

  # TODO Create test
  def can_create_words?
    is_admin_or_teacher?
  end

  # TODO Create test
  def can_create_meaning_alts?
    is_admin_or_teacher?
  end

  # TODO Create test
  def can_create_example_non_examples?
    is_admin_or_teacher?
  end

  def incomplete_fundamentals
    UserWord.where(user: self).incomplete_freestyles
  end

  def incomplete_jeopardys
    UserWord.where(user: self).incomplete_jeopardys
  end

  def complete_jeopardys
    UserWord.where(user: self).completed_jeopardys
  end

  # TODO Create test
  def incomplete_jeop_ids_not(word)
    incomplete_jeopardys.where.not(word_id: word.id).pluck(:word_id)
  end

  # TODO: Create test
  def incomplete_tag_jeop_ids_not(word)
    incomplete_jeopardys.where.not(word_id: word.id).pluck(:word_id)
  end

  def word_ids_for(tag)
    word_tags.joins(:word)
             .order("words.name ASC")
             .includes(:word)
             .where(tag: tag)
             .pluck(:word_id)
  end

  def incomplete_freestyles
    UserWord.where(user: self).incomplete_freestyles
  end

  def has_incomplete_fundamentals?
    incomplete_fundamentals.any?
  end

  def has_incomplete_jeopardys?
    incomplete_jeopardys.any?
  end

  def has_incomplete_freestyles?
    incomplete_freestyles.any?
  end

  def completed_fundamentals
    UserWord.where(user: self).completed_fundamentals
  end

  def completed_jeopardys
    UserWord.where(user: self).completed_jeopardys
  end

  def completed_freestyles
    UserWord.where(user: self).completed_freestyles
  end

  def has_completed_fundamentals?
    completed_fundamentals.any?
  end

  def has_completed_jeopardys?
    completed_jeopardys.any?
  end

  def has_completed_freestyles?
    completed_freestyles.any?
  end

  def has_games_to_play?
    has_incomplete_fundamentals? || has_incomplete_jeopardys? ||
    has_incomplete_freestyles?
  end

  def has_enough_incomplete_jeops?
    num_incomplete_jeops > 1
  end

  def has_enough_incomplete_and_complete_jeops?
    num_incomplete_and_complete_jeops > 2
  end

  # TODO: Create test
  def num_rands_needed
    if has_enough_incomplete_jeops?
      if num_incomplete_jeops == 2
        2
      elsif num_incomplete_jeops == 3
        1
      else
        0
      end
    else
      3
    end
  end

  # TODO: Create test
  # refactor into two methods
  def combine_jeop_words(word)
    my_ids = self.incomplete_jeop_ids_not(word)

    if num_rands_needed == 2
      my_words = Word.find(my_ids)
      random_words = Word.random_excluding(num_rands_needed, my_ids)
    elsif num_rands_needed == 1
      my_words = Word.find(my_ids.sample(2))
      random_words = Word.random_excluding(num_rands_needed, my_ids)
    else
      my_words = Word.find(my_ids.sample(3))
      random_words = []
    end

    my_words + random_words
  end

  # TODO: Create test
  def get_jeop_words(word)
    if has_enough_incomplete_jeops?
      [word] + combine_jeop_words(word)
    else
      [word] + Word.random_excluding(3, word.id)
    end
  end

  def last_login_nil?
    last_login.nil?
  end

  def words_added_last_day
    user_words.where(created_at: 1.days.ago..Time.now)
  end

  # TODO: Create test
  def fundamentals_completed_yesterday
    user_words.select do |uw|
      next unless uw.fundamental_completed?

      uw.fundamental_completed_yesterday?
    end
  end

  # TODO: Create test
  def jeopardys_completed_yesterday
    user_words.select do |uw|
      next unless uw.jeopardy_completed?

      uw.jeopardy_completed_yesterday?
    end
  end

  # TODO: Create test
  def freestyles_completed_yesterday
    user_words.select do |uw|
      next unless uw.freestyle_completed?

      uw.freestyle_completed_yesterday?
    end
  end

  # TODO: Create test
  def freestyles_completed_today
    user_words.select do |uw|
      next unless uw.freestyle_completed?

      uw.freestyle_completed_today?
    end
  end

  # TODO: Create test
  def has_recent_activity?
    words_added_last_day.any? ||
    fundamentals_completed_yesterday.any? ||
    jeopardys_completed_yesterday.any? ||
    freestyles_completed_yesterday.any?
  end

  # TODO: Create test
  def has_completed_freestyle_yesterday_or_today?
    freestyles_completed_yesterday.count > 0 ||
    freestyles_completed_today.count > 0
  end

  # TODO: Create test
  def completed_freestyle_on?(date)
    UserWord.where(user: self, games_completed: 3).select { |uw|
      uw.updated_at.to_date == date
    }.any?
  end

  # TODO: Create test
  def myLeksi_mastery
    words = self.num_words

    return 0 if words == 0

    (completed_freestyles.count / words.to_f * 100).round
  end

  # TODO: Create test
  def time_spent_playing
    user_words = UserWord.where(user: self)

    user_words.map { |uw| uw.game_stats.sum(:time_spent) }.inject(&:+) || 0
  end

  # TODO: Create test
  def sort_words_by_progress(asc_or_desc)
    user_words.order("games_completed #{asc_or_desc}")
              .joins(:word)
              .order("words.name")
  end

  # TODO: Create test
  def num_words
    words.count
  end

  # MOVED AS A RESULT OF SCEC & SCHOOL REFACTOR.
  # UPDATE TEST FILES/LOCATIONS
  def num_incomplete_funds
    incomplete_fundamentals.count
  end

  def num_completed_fundamentals
    completed_fundamentals.count
  end

  def num_incomplete_jeops
    incomplete_jeopardys.count
  end

  def num_completed_jeops
    completed_jeopardys.count
  end

  def num_incomplete_and_complete_jeops
    num_incomplete_jeops + num_completed_jeops
  end

  def num_incomplete_frees
    incomplete_freestyles.count
  end

  def num_completed_frees
    completed_freestyles.count
  end

  def percentage_of_fundamental_games_completed
    completed = self.num_completed_fundamentals
    not_started = self.num_incomplete_funds
    total = completed + not_started

    (completed / total.to_f * 100).round
  end

  def percentage_of_jeopardy_games_completed
    completed = self.num_completed_jeops
    not_started = self.num_incomplete_jeops
    total = completed + not_started

    (completed / total.to_f * 100).round
  end

  def percentage_of_freestyle_games_completed
    completed = self.num_completed_frees
    not_started = self.num_incomplete_frees
    total = completed + not_started

    (completed / total.to_f * 100).round
  end

  # Eventually will be deleted

  def self.baseline_gamification
    all.each do |u|
      u.points = 0

      if u.has_words?
        u.points += u.num_words
      end

      if u.has_tags?
        u.points += u.tags.count
      end

      if u.has_user_word_tags?
        u.points += u.user_word_tags.count * 2
      end

      if u.has_completed_fundamentals?
        u.points += u.completed_fundamentals.count * 3
      end

      u.save
    end
  end

  # Methods below support school pilot and may
  # be ported longterm

  def self.fs_class_one
    usernames = %w(
      22annenberg
      22bloch
      22chawla
      22kellner
      22musso
      22nino
      22parr
      22pass
      22riordan
      22seldman
      22spencer
      22sriram
      22tarta
      22vail
      22watts
      22yamazaki
      22zenkerc
    )
    where(username: usernames)
  end

  def self.fs_class_two
    usernames = %w(
      22ball
      22bugdaycay
      22caiola
      22earle
      22friedman
      22gott
      22gund-morrow
      22halverstadt
      22juneja
      22luard
      22palladino
      22pratofiorito
      22ragins
      22tartj
      22weber
      22zenkerm
    )
    where(username: usernames)
  end

  def fs_classes
    User.fs_class_one + User.fs_class_two
  end

  def self.reset_pwds_in_dev_env
    User.all.each { |u| u.update_attributes(
        password: "password",
        password_confirmation: "password"
      )
    }
  end

  def self.create_fs_usernames
    usernames = %w(
      22annenberg
      22bloch
      22chawla
      22kellner
      22musso
      22nino
      22parr
      22pass
      22riordan
      22seldman
      22spencer
      22sriram
      22tarta
      22vail
      22watts
      22yamazaki
      22zenkerc
      22ball
      22bugdaycay
      22caiola
      22earle
      22friedman
      22gott
      22gund-morrow
      22halverstadt
      22juneja
      22luard
      22palladino
      22pratofiorito
      22ragins
      22tartj
      22weber
      22zenkerm
    )

    usernames.each do |u|
      s = User.new
      s.username = u
      s.password = "password"
      s.password_confirmation = "password"
      s.role = "student"
      s.email = ""
      s.save
    end
  end

  # SCEC

  def is_demo_teacher?
    username.include?("demo_teacher_")
  end

  def self.demo_random_username
    %w(
      Constance Kozey
      Milton Doyle
      Harry White
      Jordon Gleason
      Koby Nolan
      Dominique Tremblay
      Matilda Bergnaum
      Otis MacGyver
      Lisandro Toy
      Marcos Hartmann
      Lurline Dooley
      Shyanne Schoen
      Ivah Smitham
      Madilyn Wilderman
      Earnestine Okuneva Jr.
      Hal Harris
      Owen Rodriguez
      Ivory Gislason
      Karson Weimann
      Leland Gislason
      Rod Heaney
      Leila Wyman
      Natalie Watsica
      Tate Borer
      Ignatius Fadel V
      Josue Emmerich
      Trenton Bashirian
      Derick Wisoky
      Heaven Pacocha
      Reyes Casper
      Lamont Schaden
      Kirstin Larkin
      Marcia Treutel
      Olen King
      Kim Cruickshank
      Gregorio Wilderman
      Braulio Morar
      Doug Prohaska
      Lupe Mraz II
      Tevin McLaughlin
      Kylie Daugherty
      Adriana Tremblay
      Jalen Hayes
      Kailey Effertz
      Omari Cremin
      Kathlyn Borer II
      Domenica Tremblay
      Edward Medhurst
      Gaetano Bogisich
      Preston West V
      Arvel Harber
      Louisa Prohaska
      Bertram Collins
      Colin Wilkinson
      Janie Wiza
      Jerald Lemke
      Felicita Brakus
      Jadyn Heaney
      Dale Berge
      Ruthie Crooks
      Retha Muller
      Ariane Streich
      Gus Harvey
      Clotilde Heathcote
      Christiana Auer
      Phyllis Leuschke Sr.
      Abigale Hagenes
      Laila Borer
      Marianna Sipes DVM
      Abigail Medhurst
      Polly Jerde
      Ahmad Muller
      Elvis Kuhn
      Dale Schuster
      Zoie Ondricka
      Vada Gorczany
      Kaylah Beier DVM
      Mozelle Hilll
      Matilde Lockman
      Paul Schmidt
      Norval Weber
      Gavin Barrows
      Loren Kozey
      Alec Cremin
      Darren Kulas
      Hannah Stokes
      Paris Vandervort
      Freddy Cassin
      Araceli Wisozk
      Elnora Ullrich
      Aubree Mante
      Soledad Kutch
      Nikita Berge
      Lauretta Padberg
      Rigoberto Stamm
      Sandra Hermiston
      Danika Lindgren
      Una Grady
      Duncan Beer
      Kari Hermann
    ).sample
  end
end
