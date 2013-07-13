class Tag < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 20}

  belongs_to :user
  belongs_to :gist
end
