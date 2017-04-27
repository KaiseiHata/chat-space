# DB設計
## users table(created by 'devise')
| Column  | Type  |  Options                       |
|:--------|:------|:-------------------------------|
|name     |string |null: false, unique: true, index|
|email    |string |null: false                     |
|password |string |null: false                     |

### Association
- has_many :groups, though: :users_groups
- has_many :users_groups
- has_many :messages

## groups table
|  Column  | Type  |  Options  |
|:---------|:------|:----------|
|name      |string |null: false, unique: true|

### Association
- has_many :users, though: :users_groups
- has_many :users_groups
- has_many :messages

## users_groups table
|Column  |Type   |Options          |
|:-------|:------|:----------------|
|user_id |integer|foreign_key: true|
|group_id|integer|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :group

## messages table
| Column | Type  | Options         |
|:-------|:------|:----------------|
|body    |text   |null: false      |
|image   |string |                 |
|user_id |integer|foreign_key: true|
|group_id|integer|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :group
