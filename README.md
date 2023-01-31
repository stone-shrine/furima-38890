# README

# テーブル設計

## Usersテーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | string | null: false |

### Association
has_many :items
has_many :orders


## Itemsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user_id            | references | null: false, foreign_key: true |
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| category           | string     | null: false                    |
| status             | string     | null: false                    |
| ship_from          | string     | null: false                    |
| payment            | string     | null: false                    |
| lead_time          | string     | null: false                    |
| price              | string     | null: false                    |

### Association
belongs_to :user
has_one :order


## Ordersテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user_id            | references | null: false, foreign_key: true |
| item_id            | references | null: false, foreign_key: true |
| paid               | string     | null: false                    |

### Association
belongs_to :user
belongs_to :item


## Addressesテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| order_id           | references | null: false, foreign_key: true |
| zip_code           | string     | null: false                    |
| prefecture         | string     | null: false                    |
| city               | string     | null: false                    |
| street             | string     | null: false                    |
| building           | string     | null: false                    |
| phone              | string     | null: false                    |

### Association
belongs_to :order