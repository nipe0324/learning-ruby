Message.delete_all
Message.create!([
  { user: 'Tom',   text: 'Good morning' },
  { user: 'John',  text: 'Good afternoon' },
  { user: 'Emily', text: 'Good evening' }
])
