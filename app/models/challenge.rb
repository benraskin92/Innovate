class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :solutions

  validates :title, presence: true
  validates :category, presence: true
  validates :description, presence: true

	def self.search(search)
		if search 
			where 'title LIKE ?', "%#{search}%"
		else
			puts 'No results'
		end
	end

end
