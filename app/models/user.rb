class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :birthday, presence: true

  with_options presence: true do
    # ひらがな、カタカナ、漢字のみ許可する
    validates :last_name, :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters.' }
    # カタカナのみ許可する
    validates :last_name_kana, :first_name_kana,
              format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters.' }
    # パスワードに半角英数字混合
    validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "is invalid. Include both letters and numbers" }

  end
end
