//Сущности для реляционной БД

Table users {
  id bigint [primary key, unique, increment]
  username varchar(60) [not null]
  created_at timestamp [not null, default: 'now']
}

Table publications {
  id bigint [primary key, unique, increment]
  user_id bigint [not null]
  description text(1000) [note: 'Content of the post']
  location varchar(30)
  likes_count integer [default: 0]
  created_at timestamp [not null, default: 'now']
  Indexes {
    (user_id) [name:"idx_publications_user_id"]
    (location) [name:"idx_publications_location"]
  }
}
Ref user_publications: publications.user_id > users.id // many-to-one

Table comments {
  id numeric(20,0) [primary key, unique, increment]
  publication_id bigint [not null]
  author_user_id bigint [not null]
  description text(400) [note: 'Content of the comment']
  created_at timestamp [not null, default: 'now']
  Indexes {
    (publication_id) [name:"idx_comments_publication_id"]
  }
}
Ref user_comments: comments.author_user_id > users.id
Ref publication_comments: comments.publication_id > publications.id

Table subscriptions {
  id bigint [primary key, unique, increment]
  user_id bigint [not null]
  subscriber_user_id bigint [not null]
  created_at timestamp [not null, default: 'now']
  Indexes {
    (user_id,subscriber_user_id) [unique,name:"uniq_idx_user_id_subscriptions_user_id"]
    (user_id) [name:"idx_subscriptions_user_id"]
    (subscriber_user_id) [name:"idx_subscriptions_subscriber_user_id"]
  }
}
Ref user_subscriptions: subscriptions.user_id > users.id // many-to-one
Ref user_subscriptions: subscriptions.subscriber_user_id > users.id // many-to-one

Table attaches {
  id bigint [primary key, unique]
  user_id bigint [not null]
  publication_id bigint [not null]
  mime_type varchar(20) [not null]
  file_type varchar(20) [not null]
  url varchar(400) [not null]
  size integer [not null, note: 'Size to byte']
  created_at timestamp [not null, default: 'now']
  Indexes {
    (user_id) [name:"idx_attaches_user_id"]
    (publication_id) [name:"idx_attaches_publication_id"]
  }
}
Ref publication_attaches: attaches.publication_id > publications.id // many-to-one
Ref user_attaches: attaches.user_id > users.id // many-to-one
