class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :solutions

  validates :title, presence: true
  validates :category, presence: true
  validates :description, presence: true

end
