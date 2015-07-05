Article.create!([
  { title: 'article 1', content: 'client article', remote_tweet_id: 1 },
  { title: 'article 2', content: 'client article', remote_tweet_id: 2 },
])

Tag.create!([
  { name: 'client tag 1', remote_tag_id: 1 },
  { name: 'client tag 2', remote_tag_id: 2 },
])

ArticleTag.create!([
  { article_id: 1, tag_id: 1 },
  { article_id: 1, tag_id: 2 }
])
