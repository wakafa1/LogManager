class User < ApplicationRecord
  has_secure_password
  has_many :logs
  attr_accessor :remember_token

  validates :password, presence: true
  validates :password_confirmation, presence: true

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, format: {
    with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Email
          Format Invalid"
  }, uniqueness: { case_sensitive: false }

  # 请在下面完成要求的功能
  #*********begin*********#
  # 计算用户的访问令牌并存至数据库
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 核对用户提供的访问令牌是否有效
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # 清空用户访问令牌
  def forget
    update_attribute(:remember_digest, nil)
  end
  #********* end *********#

  class << self
    # 返回提供参数 string 的散列摘要值
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # 返回一个22位长的随机字符串
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
