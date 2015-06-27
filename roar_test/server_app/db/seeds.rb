Tweet.create!([
  { content: 'tweet 1' },
  { content: 'tweet 2' },
])

Tag.create!([
  { id: 1000, name: 'tag 1' },
  { id: 1001, name: 'tag 2' },
])

TweetTag.create!([
  { tweet_id: 1, tag_id: 1000 },
  { tweet_id: 1, tag_id: 1001 }
])
