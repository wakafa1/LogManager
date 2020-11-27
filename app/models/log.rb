class Log < ApplicationRecord
  belongs_to :user
  has_many :datapoints

  validates :filename, presence: true
  validates :user, presence: true
end
