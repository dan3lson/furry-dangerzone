class User < ActiveRecord::Base
  has_secure_password

  has_many :user_words, dependent: :destroy
  has_many :words, through: :user_words
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags
  has_many :user_word_tags, dependent: :destroy
  has_many :word_tags, through: :user_word_tags
  has_many :freestyles, through: :user_words
  has_many :activities, dependent: :destroy

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 33 }
  # validates :points, presence: true
  validates :first_name, length: { maximum: 50 }
  validates :last_name, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  before_create { self.username = username.downcase }

  # TODO: Create test
  def exists?
    !User.find_by(username: self.username).nil?
  end

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
    !UserWord.where(user: self).empty?
  end

  def has_tag?(tag)
    !tags.where(name: tag.name).empty?
  end

  def has_tags?
    !UserTag.where(user: self).empty?
  end

  def has_user_word_tags?
    !UserWordTag.where(user: self).empty?
  end

  def is_admin?
    type == "Admin"
  end

  def is_teacher?
    type == "Teacher" || type == "Admin"
  end

  def is_admin_or_teacher?
    is_admin? || is_teacher?
  end

  def is_student?
    type == "Student" || is_teacher? || is_admin?
  end

  # TODO Create test
  def is_brainiac?
    type == "Brainiac" || is_student? || is_admin?
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
    UserWord.where(user: self).incomplete_fundamentals
  end

  def incomplete_jeopardys
    UserWord.where(user: self).incomplete_jeopardys
  end

  def complete_jeopardys
    UserWord.where(user: self).completed_jeopardys
  end

  # TODO Create test
  def incomplete_words
    incomplete_fundamentals + incomplete_jeopardys + incomplete_freestyles
  end

  # TODO Create test
  def has_incomplete_word?
    incomplete_words.any?
  end

  # TODO Create test
  def has_incomplete_not?(word)
    incomplete_words.delete_if { |uw| uw.word.id == word.id  }.any?
  end

  # TODO Create test
  def rand_incomplete_word
    incomplete_words.sample
  end

  # TODO Create test
  def rand_incomplete_not(word)
    incomplete_words.delete_if  { |uw| uw.word.id == word.id }.sample
  end

  # TODO Create test
  def incomplete_jeop_ids_not(word)
    incomplete_jeopardys.where.not(word_id: word.id).pluck(:word_id)
  end

  # TODO: Create test
  def incomplete_tag_jeop_ids_not(word)
    incomplete_jeopardys.where.not(word_id: word.id).pluck(:word_id)
  end

  # TODO Create test
  def incomplete_free_ids_not(word)
    incomplete_freestyles.where.not(word_id: word.id).pluck(:word_id)
  end

  # TODO Create test
  def incomplete_frees_not(word)
    Word.find(incomplete_free_ids_not(word))
  end

  # TODO Create test
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

  # TODO Create test
  def unreviewed_frees
    freestyles.unreviewed.includes(:user_word)
  end

  # TODO Create test
  def reviewed_frees
    freestyles.reviewed.includes(:user_word)
  end

  # TODO Create test
  def passed_frees
    freestyles.pass.includes(:user_word)
  end

  # TODO Create test
  def redo_frees
    freestyles.redo.includes(:user_word)
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

  # TODO Create test
  def has_reviewed_frees?
    !freestyles.reviewed.empty?
  end

  def has_games_to_play?
    has_incomplete_fundamentals? ||
    has_incomplete_jeopardys? ||
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
    my_words = Word.find(my_ids);

    if num_rands_needed == 2
      random_words = Word.random_excluding(num_rands_needed, my_ids)
    elsif num_rands_needed == 1
      my_words = my_words.sample(2)
      random_words = Word.random_excluding(num_rands_needed, my_ids)
    else
      my_words = my_words.sample(3)
      random_words = []
    end

    my_words + random_words
  end

  # TODO: Create test
  def get_jeop_words(word)
    if has_enough_incomplete_jeops?
      combine_jeop_words(word) << word
    else
      Word.random_excluding(3, word.id) << word
    end
  end

  def last_login_nil?
    last_login.nil?
  end

  # TODO: Create test
  def words_added_last_day
    UserWord.includes(:word)
            .where(user: self)
            .last_24_hours(:created_at)
            .order(updated_at: :desc)
  end

  # TODO: Create test
  def funds_compl_last_24_hrs
    user_words.completed_fundamentals
              .last_24_hours
              .order(updated_at: :desc)
  end

  # TODO: Create test
  def jeops_compl_last_24_hrs
    user_words.completed_jeopardys
              .last_24_hours
              .order(updated_at: :desc)
  end

  # TODO: Create test
  def frees_compl_last_24_hrs
    completed_freestyles.last_24_hours.order(updated_at: :desc)
  end

  # TODO: Create test
  def has_recent_activity?
    !Activity.where(user: self).last_24_hours.empty?
  end

  # TODO: Create test (used to calculate streak in UserHelper)
  def completed_freestyle_on?(date)
    UserWord.where(user: self, games_completed: 3)
            .select { |uw| uw.updated_at.to_date == date }
            .any?
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
    user_words.map { |uw| uw.game_stats.sum(:time_spent) }
              .inject(&:+) || 0
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

  # TODO: Create test
  def num_tags
    tags.count
  end

  # MOVED AS A RESULT OF SCEC & SCHOOL REFACTOR.
  # TODO UPDATE TEST FILES/LOCATIONS
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

  def self.reset_dev_pwds
    User.all.each { |u| u.update_attributes(
      password: "password",
      password_confirmation: "password"
    )}
  end
end
