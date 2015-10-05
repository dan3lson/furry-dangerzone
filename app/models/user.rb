class User < ActiveRecord::Base
  has_many :user_words, dependent: :destroy
  has_many :words, through: :user_words
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags
  has_many :user_word_tags, dependent: :destroy
  has_many :word_tags, through: :user_word_tags
  has_many :reviews

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 33 }
  validates :points, presence: true
  validates :first_name, length: { maximum: 50 }
  validates :last_name, length: { maximum: 50 }
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true,
            uniqueness: { case_sensitive: false }


  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  before_create { self.username = username.downcase }
  before_create { self.email = email.downcase }

  def has_words?
    self.words.any?
  end

  def already_has_word?(word)
    self.words.include?(word)
  end

  def has_tags?
    self.tags.any?
  end

  def has_user_word_tags?
    self.user_word_tags.any?
  end

  def already_has_tag?(tag)
    self.tags.include?(tag)
  end

  def is_admin?
    self.role == "admin"
  end

  def has_reached_free_version_limit?
    self.words.count > 9
  end

  def self.top_ten_highest_points
    order("points DESC").take(10)
  end

  def incomplete_fundamentals
    games = []

    user_words.each do |uw|
      games << uw unless uw.fundamental_completed?
    end

    games
  end

  def incomplete_jeopardys
    games = []

    user_words.each do |uw|
      games << uw if uw.jeopardy_not_started?
    end

    games
  end

  def incomplete_freestyles
    games = []

    user_words.each do |uw|
      games << uw if uw.freestyle_not_started?
    end

    games
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

  def has_at_least_four_incomplete_jeopardys?
    incomplete_jeopardys.count > 3
  end

  def completed_fundamentals
    games = []

    user_words.each do |uw|
      games << uw if uw.fundamental_completed?
    end

    games
  end

  def completed_jeopardys
    games = []

    user_words.each do |uw|
      games << uw if uw.jeopardy_completed?
    end

    games
  end

  def completed_freestyles
    games = []

    user_words.each do |uw|
      games << uw if uw.freestyle_completed?
    end

    games
  end

  def has_completed_fundamentals?
    completed_fundamentals.any?
  end

  def has_completed_jeopardys?
    completed_fundamentals.any?
  end

  def has_completed_freestyles?
    completed_freestyles.any?
  end

  def last_login_nil?
    last_login.nil?
  end

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

  def self.create_fs_users
    class_one = %w(
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
      22zenker
    )

    class_two = %w(
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
      22zenker
    )

    class_one.each do |s|
      u = User.new
      u.username = s
      u.password = "fri3nds"
      u.password_confirmation = "fri3nds"
      u.role = "student"

      if u.save
        puts "#{u.username}\'s account is now active."
      else
        puts "#{u.error.messages}"
      end
    end
  end
end
