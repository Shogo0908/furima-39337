# README
## Usersテーブル

| Column          | Type   | Options                        |
| --------------- | ------ | ------------------------------ |
| id              | integer| null: false, primary_key: true |
| name_kanji      | string | null: false                    |
| name_katakana   | string | null: false                    |
| email           | string | unique: true, null: false      |
| encrypted_password | string | null: false                 |
| birth_date      | date   | null: false                    |

### Association
- has_many :items
- has_many :purchases


## Itemsテーブル

| Column               | Type   | Options                        |
| -------------------- | ------ | ------------------------------ |
| id                   | integer| null: false, primary_key: true |
| name                 | string | null: false                    |
| price                | integer| null: false                    |
| description          | text   | null: false                    |
| category_id          | integer| null: false                    |
| condition_id         | integer| null: false                    |
| delivery_fee_id      | integer| null: false                    |
| ship_from_location_id| integer| null: false                    |
| shipping_date_id     | integer| null: false                    |
| user_id              | integer| foreign_key: true, null: false |

### Association
- belongs_to :user
- has_one :purchase
- has_one_attached :image


## Imagesテーブル

| Column   | Type   | Options                        |
| -------- | ------ | ------------------------------ |
| id       | integer| null: false, primary_key: true |
| item_id  | integer| foreign_key: true, null: false |
| url      | string | null: false                    |

### Association
- belongs_to :item


## Purchasesテーブル

| Column   | Type   | Options                        |
| -------- | ------ | ------------------------------ |
| id       | integer| null: false, primary_key: true |
| user_id  | integer| foreign_key: true, null: false |
| item_id  | integer| foreign_key: true, null: false |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipment


## Shipmentsテーブル

| Column          | Type   | Options                        |
| --------------- | ------ | ------------------------------ |
| id              | integer| null: false, primary_key: true |
| postal_code     | string | null: false                    |
| prefecture_id   | integer| null: false                    |
| city            | string | null: false                    |
| address         | string | null: false                    |
| building_name   | string |                                |
| phone_number    | string | null: false                    |
| purchase_id     | integer| foreign_key: true, null: false |

### Association
- belongs_to :purchase
