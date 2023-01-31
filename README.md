# README

# テーブル設計

## Usersテーブル
| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_date         | date   | null: false               |

### Association
has_many :items
has_many :orders


## Itemsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| status_id          | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| payment_id         | integer    | null: false                    |
| lead_time_id       | integer    | null: false                    |
| price              | integer    | null: false                    |

### Association
belongs_to :user
has_one :order


## Ordersテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

### Association
belongs_to :user
belongs_to :item
has_one :address


## Addressesテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| order              | references | null: false, foreign_key: true |
| zip_code           | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city               | string     | null: false                    |
| street             | string     | null: false                    |
| building           | string     |                                |
| phone              | string     | null: false                    |

### Association
belongs_to :order