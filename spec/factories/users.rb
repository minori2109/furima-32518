FactoryBot.define do
  factory :user do
    nickname          { Faker::Name.initials }
    email             { Faker::Internet.free_email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }

    # 本人確認
    last_name         { Gimei.last.kanji }
    first_name        { Gimei.first.kanji }
    last_name_kana    { Gimei.last.katakana }
    first_name_kana   { Gimei.first.katakana }
    birthday          { Faker::Date.birthday(min_age: 5, max_age: 90) }
  end
end
