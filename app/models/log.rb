class Log < ApplicationRecord
  belongs_to :user

  validates :filename, presence: true
  validates :user, presence: true
end
