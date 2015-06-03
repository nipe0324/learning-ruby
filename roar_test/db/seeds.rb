[Album, Singer, AlbumSinger, Song].each(&:delete_all)

Album.create!([
  { name: 'album 1' },
  { name: 'album 2' },
])

Singer.create!([
  { name: 'singer 1' },
  { name: 'singer 2' },
])

AlbumSinger.create!([
  { album: Album.first,  singer: Singer.first   },
  { album: Album.second, singer: Singer.second },
])

Song.create!([
  { name: 'song A', album: Album.first,  singer: Singer.first  },
  { name: 'song B', album: Album.first,  singer: Singer.first  },
  { name: 'song C', album: Album.first,  singer: Singer.first  },
  { name: 'song 1', album: Album.second, singer: Singer.second },
  { name: 'song 2', album: Album.second, singer: Singer.second },
])
