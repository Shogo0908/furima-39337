# README
## Usersテーブル

| Column            | Type   | Options     |
| ----------------- | ------ | ----------- |
| nickname          | string | null: false |
| email             | string | null: false |
| encrypted_password| string | null: false |
| family_name       | string | null: false |
| first_name        | string | null: false |
| family_name_kana  | string | null: false |
| first_name_kana   | string | null: false |
| birthday          | date   | null: false |

### Association
- has_many :items
- has_many :purchases


## Itemsテーブル

| Column               | Type   | Options                        |
| -------------------- | ------ | ------------------------------ |
| name                 | string | null: false                    |
| price                | integer| null: false                    |
| description          | text   | null: false                    |
| category_id          | integer| null: false                    |
| condition_id         | integer| null: false                    |
| delivery_fee_id      | integer| null: false                    |
| prefecture_id        | integer| null: false                    |
| shipping_date_id     | integer| null: false                    |
| user                 | references| foreign_key: true, null: false |

### Association
- belongs_to :user
- has_one :purchase
- has_one_attached :image

## Purchasesテーブル

| Column   | Type   | Options                        |
| -------- | ------ | ------------------------------ |
| user     | references| foreign_key: true, null: false |
| item     | references| foreign_key: true, null: false |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipment


## Shipmentsテーブル

| Column          | Type   | Options                        |
| --------------- | ------ | ------------------------------ |
| postal_code     | string | null: false                    |
| prefecture_id   | integer| null: false                    |
| city            | string | null: false                    |
| address         | string | null: false                    |
| building_name   | string |                                |
| phone_number    | string | null: false                    |
| purchase        | references| foreign_key: true, null: false |

### Association
- belongs_to :purchase
