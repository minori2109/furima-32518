## usersテーブル
| Column           | Type       | Options                         |
| ---------------- | ---------- | ------------------------------- |
| nickname         | string     | null: false                     |
| email            | string     | null: false                     |
| encrypt_password | string     | null: false                     |
| last_name        | string     | null: false                     |
| first_name       | string     | null: false                     |
| last_name_kana   | string     | null: false                     |
| first_name_kana  | string     | null: false                     |
| birthday         | date       | null: false                     |

### Association
- has_many :items
- has_many :orders

## itemsテーブル
| Column             | Type         | Options                         |
| ------------------ | ------------ | ------------------------------- |
| item_name          | string       | null: false                     |
| item_detail        | string       | null: false                     |
| item_category_id   | integer      | null: false                     |
| item_status_id     | integer      | null: false                     |
| shipping_fee_id    | integer      | null: false                     |
| shipping_area_id   | integer      | null: false                     |
| shipping_date_id   | integer      | null: false                     |
| item_price         | integer      | null: false                     |
| user               | references   | null: false, foreign_key: true  |

### Association
- belongs_to :user
- has_one    :order

## ordersテーブル
| Column        | Type       | Options                         |
| ------------- | ---------- | ------------------------------- |
| user          | references | null: false, foreign_key: true  |
| item          | references | null: false, foreign_key: true  |

### Association
- belongs_to :user
- belongs_to :item
- has_one    :address

## addressesテーブル
| Column        | Type       | Options                         |
| ------------- | ---------- | ------------------------------- |
| postcode      | text       | null: false                     |
| prefecture    | text       | null: false                     |
| city          | text       | null: false                     |
| block         | text       | null: false                     |
| building      | text       | null: false                     |
| phone_number  | int        | null: false                     |
| order         | references | null: false, foreign_key: true  |

### Association
- belongs_to :order