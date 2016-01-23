define ->
  name: 'github_client'
  tables: [
    name: 'user'
    columns: [
      name: 'id'
      type: 'integer primary key'
    ,
      name: 'name'
      type: 'text'
    ,
      name: 'token'
      type: 'text'
    ,
      name: 'hashed_token'
      type: 'text'
    ,
      name: 'avatar'
      type: 'text'
    ,
      name: 'created_at'
      type: 'text'
    ,
      name: 'updated_at'
      type: 'text'
    ]
  ]
