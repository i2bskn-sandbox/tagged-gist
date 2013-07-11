class Tag < ActiveRecord::Base
  # <TODO> To be eliminate the duplicate tag name of the same file.
  validates :name, presence: true, length: {maximum: 20}

  belongs_to :user
  belongs_to :gist
end
