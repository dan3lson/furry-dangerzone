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
  validates :first_name, length: { maximum: 50 }
  validates :last_name, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  scope :most_logins, -> { order("users.num_logins DESC") }
  scope :least_logins, -> { order("users.num_logins ASC") }

  before_create { self.username = username.downcase }

  # TODO: Create test. Serialize like FreestyleLekTale.rb
  def self.set_up_login_data(user)
    datetime_now = DateTime.now
    user.last_login = datetime_now
    user.login_history = ""
    user.login_history += datetime_now.to_s << "|"
    user.num_logins += 1
  end

  # TODO: Create test
  def has_name?
    !first_name.nil? || !last_name.nil?
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

  def is_brainiac?
    type == "Brainiac"
  end

  def is_admin?
    type == "Admin"
  end

  def is_teacher?
    type == "Teacher" || type == "Admin"
  end

  def is_student?
    type == "Student" || is_teacher? || is_admin?
  end

  # TODO Create test
  def word_ids_for(tag)
    word_tags.joins(:word)
             .order("words.name ASC")
             .includes(:word)
             .where(tag: tag)
             .pluck(:word_id)
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

  # TODO Create test
  def has_reviewed_frees_last_24_hrs?
    !freestyles.reviewed.last_24_hours.empty?
  end

  # TODO: Create test
  def words_added_last_day
    UserWord.includes(:word)
            .where(user: self)
            .last_24_hours(:created_at)
            .order(updated_at: :desc)
  end

  # TODO: Create test
  def has_recent_activity?
    !Activity.where(user: self).last_24_hours.empty?
  end

  # TODO: Create test
  def num_words
    words.count
  end

  # TODO: Create test
  def num_tags
    tags.count
  end
end
