class Tag < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 20}
  validate :duplicate_check

  belongs_to :user
  belongs_to :gist

  class << self
    def duplicate?(options={})
      where("name = :name AND user_id = :user AND gist_id = :gist", options).exists?
    end
  end

  private
  def duplicate_check
    if Tag.duplicate?(name: name, user: user_id, gist: gist_id)
      errors.add(:name, "is a duplicated")
    end
  end
end
