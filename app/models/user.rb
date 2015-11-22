class User < ActiveRecord::Base
  has_many :user_words, dependent: :destroy
  has_many :words, through: :user_words
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags
  has_many :user_word_tags, dependent: :destroy
  has_many :word_tags, through: :user_word_tags
  has_many :reviews
  has_many :feedbacks

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 33 }
  validates :points, presence: true
  validates :first_name, length: { maximum: 50 }
  validates :last_name, length: { maximum: 50 }
  validates :login_history, presence: true
  validates :streak, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true,
            uniqueness: { case_sensitive: false }


  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  before_create { self.username = username.downcase }
  before_create { self.email = email.downcase }

  def has_words?
    words.any?
  end

  def already_has_word?(word)
    words.include?(word)
  end

  def has_tags?
    tags.any?
  end

  def has_user_word_tags?
    user_word_tags.any?
  end

  def already_has_tag?(tag)
    tags.include?(tag)
  end

  def is_admin?
    role == "admin"
  end

  def is_teacher?
    role == "teacher" || role == "admin"
  end

  def is_student?
    role == "student"
  end

  def can_create_words?
    is_admin? || is_teacher?
  end

  def self.top_ten_highest_points
    order("points DESC").take(10)
  end

  def incomplete_fundamentals
    UserWord.where(user: self).select { |uw| uw.fundamental_not_completed? }
  end

  def incomplete_jeopardys
    UserWord.where(user: self).select do |uw|
      uw.jeopardy_not_completed?
    end.keep_if { |uw| uw.games_completed == 1 }
  end

  def incomplete_freestyles
    UserWord.where(user: self).select do |uw|
      uw.freestyle_not_completed?
    end.keep_if { |uw| uw.games_completed == 2 }
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
    UserWord.where(user: self).select { |uw| uw.fundamental_completed? }
  end

  def completed_jeopardys
    UserWord.where(user: self).select { |uw| uw.jeopardy_completed? }
  end

  def completed_freestyles
    UserWord.where(user: self).select { |uw| uw.freestyle_completed? }
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

  def has_enough_jeopardy_words?
    incomplete_jeopardys.count + completed_jeopardys.count > 3
  end

  def last_login_nil?
    last_login.nil?
  end

  def words_added_last_day
    user_words.where(created_at: 1.days.ago..Time.now)
  end

  def fundamentals_completed_yesterday
    user_words.select do |uw|
      next unless uw.fundamental_completed?

      uw.fundamental_completed_yesterday?
    end
  end

  def jeopardys_completed_yesterday
    user_words.select do |uw|
      next unless uw.jeopardy_completed?

      uw.jeopardy_completed_yesterday?
    end
  end

  def freestyles_completed_yesterday
    user_words.select do |uw|
      next unless uw.freestyle_completed?

      uw.freestyle_completed_yesterday?
    end
  end

  def freestyles_completed_today
    user_words.select do |uw|
      next unless uw.freestyle_completed?

      uw.freestyle_completed_today?
    end
  end

  def has_recent_activity?
    words_added_last_day.any? ||
    fundamentals_completed_yesterday.any? ||
    jeopardys_completed_yesterday.any? ||
    freestyles_completed_yesterday.any?
  end

  def has_completed_freestyle_yesterday_or_today?
    freestyles_completed_yesterday.count > 0 ||
    freestyles_completed_today.count > 0 
  end

  def completed_freestyle_on?(date)
    UserWord.where(user: self, games_completed: 3).select { |uw|
      uw.updated_at.to_date == date
    }.any?
  end

  # Eventually will be deleted

  def self.baseline_gamification
    all.each do |u|
      u.points = 0

      if u.has_words?
        u.points += u.words.count
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

  # METHODS BELOW ONLY SUPPORT CURRENT SCHOOL PILOT

  def self.fs_class_one
    %w(
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
    ).map { |u| User.find_by(username: u) }
  end

  def self.fs_class_two
    %w(
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
    ).map { |u| User.find_by(username: u) }
  end

  def fs_classes
    User.fs_class_one + User.fs_class_two
  end

  def self.reset_rails_c_pwds
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
end
