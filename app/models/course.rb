class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: { :minimum => 5 }

  belongs_to :user
  has_many :lessons, dependent: :destroy
  
  def to_s
    title
  end

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :description

  LANGUAGES = [:"English", :"Spanish", :"Portuguese"]
  def self.languages
    LANGUAGES.map { |language| [language, language] }
  end

  LEVELS = [:"All levels", :Beginner, :Intermediate, :Advanced].freeze
  def self.levels
    LEVELS.map { |level| [level, level] }
  end

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

end
