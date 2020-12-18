class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)\w{6,}\z/.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'パスワードには英字と数字の両方を含めて設定してください' }

  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze

  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: VALID_NAME_REGEX, message: 'は全角で入力してください' }
    validates :first_name, format: { with: VALID_NAME_REGEX, message: 'は全角で入力してください' }
    validates :last_name_kana, format: { with: VALID_NAME_KANA_REGEX, message: 'は全角カタカナで入力してください' }
    validates :first_name_kana, format: { with: VALID_NAME_KANA_REGEX, message: 'は全角カタカナで入力してください' }
    validates :birthday
  end
end
