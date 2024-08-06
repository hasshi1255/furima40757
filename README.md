
## Users Table
| Column             | Type    | Options                  |
|--------------------|---------|--------------------------|
| nickname           | string  | null: false              |
| email              | string  | null: false, unique: true|
| encrypted_password | string  | null: false              |

### Association
- has_many :items
- has_many :purchases

## Items Table
| Column            | Type    | Options                      |
|-------------------|---------|------------------------------|
| name              | string  | null: false                  |
| description       | text    | null: false                  |
| category_id       | integer | null: false                  |
| condition_id      | integer | null: false                  |
| shipping_cost_id  | integer | null: false                  |
| prefecture_id     | integer | null: false                  |
| shipping_days_id  | integer | null: false                  |
| price             | integer | null: false                  |
| user_id           | integer | null: false, foreign_key: true|

### Association
- belongs_to :user
- has_many :item_images
- has_one :purchase

## Categories Table
| Column | Type   | Options     |
|--------|--------|-------------|
| name   | string | null: false |

### Association
- has_many :items

## Conditions Table
| Column | Type   | Options     |
|--------|--------|-------------|
| name   | string | null: false |

### Association
- has_many :items

## Shipping_costs Table
| Column | Type   | Options     |
|--------|--------|-------------|
| name   | string | null: false |

### Association
- has_many :items

## Prefectures Table
| Column | Type   | Options     |
|--------|--------|-------------|
| name   | string | null: false |

### Association
- has_many :items
- has_many :shipping_addresses

## Shipping_days Table
| Column | Type   | Options     |
|--------|--------|-------------|
| name   | string | null: false |

### Association
- has_many :items

## Item_images Table
| Column   | Type    | Options                      |
|----------|---------|------------------------------|
| item_id  | integer | null: false, foreign_key: true|
| image    | string  | null: false                  |

### Association
- belongs_to :item

## Purchases Table
| Column  | Type    | Options                      |
|---------|---------|------------------------------|
| user_id | integer | null: false, foreign_key: true|
| item_id | integer | null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## Shipping_addresses Table
| Column        | Type    | Options                      |
|---------------|---------|------------------------------|
| purchase_id   | integer | null: false, foreign_key: true|
| postal_code   | string  | null: false                  |
| prefecture_id | integer | null: false                  |
| city          | string  | null: false                  |
| address       | string  | null: false                  |
| building_name | string  |                              |
| phone_number  | string  | null: false                  |

### Association
- belongs_to :purchase
- belongs_to :prefecture
