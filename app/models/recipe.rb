class Recipe < ActiveRecord::Base
  attr_accessible :description, :name, :month, :year, :image, :is_charged, :deadline
  has_attached_file :image

  validates :description, :name, :month, :year, :deadline, presence: true
  validates :image, presence: true unless @id
  validate :not_duplicate_month

  has_many :comments

  def charge
    self.is_charged = true
  end

  def has_been_charged?
    self.is_charged
  end

  def human_date
    "#{Date::MONTHNAMES[month]} #{year}"
  end

  def self.current_recipe
    Recipe.find_by_month_and_year(Date.today.month, Date.today.year)
  end

  private

    def not_duplicate_month
      r = Recipe.find_by_month_and_year(month, year)
      errors.add(:month, "already exists") if r && r.id != id
    end

end
