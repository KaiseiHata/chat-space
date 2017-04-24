# DB設計
## users table(created by 'devise')
| Column  | Type  |  Options  |
|:--------|:------|:----------|
|user_name|integer|null: false|
|email    |string |null: false|
|password |string |null: false|

### Association
- has_many :groups, though: :users_groups
- has_many :messages

## groups table
|  Column  | Type  |  Options  |
|:---------|:------|:----------|
|group_name|string |null: false|

### Association
- has_many :users, though: :users_groups
- has_many :messages

## users_groups table
|Column  |Type   |  Options  |
|:------ |:-- ---|:----------|
|user_id |integer|           |
|group_id|integer|           |

### Association
- belongs_to :user
- belongs_to :group

## messages table
| Column | Type  | Options |
|:-------|:------|:--------|
|body    |text   |         |
|image   |text   |         |
|user_id |integer|         |
|group_id|integer|         |

### Association
- belongs_to :user
- belongs_to :group
