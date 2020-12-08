class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)\w{6,}\z/.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'Include both letters and numbers' }

  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze

  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: VALID_NAME_REGEX, message: 'Full-width characters' }
    validates :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'Full-width characters' }
    validates :last_name_kana, presence: true, format: { with: VALID_NAME_KANA_REGEX, message: 'Full-width katakana characters' }
    validates :first_name_kana, presence: true, format: { with: VALID_NAME_KANA_REGEX, message: 'Full-width katakana characters' }
    validates :birthday
  end
end
