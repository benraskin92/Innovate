class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :solutions
  has_many :relationships, foreign_key: "followed_id"
  has_many :followed_by, through: :relationships, source: :user

  validates :title, presence: true
  validates :category, presence: true
  validates :description, presence: true

  has_attached_file :attachment
	validates_attachment :attachment, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

	def self.search(search)
		if search 
			where 'LOWER(title) LIKE ? OR LOWER(description) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%"
		else
			puts 'No results'
		end
	end

end
