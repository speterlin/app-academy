# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
  select
    artist
  from
    albums
  join
    tracks on albums.asin = tracks.album
  where
    song = 'Alison'

  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
  select
    artist
  from
    albums
  join
    tracks on albums.asin = tracks.album
  where
    song = 'Exodus'

  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
  select
    song
  from
    tracks
  -- join
  --   tracks on albums.asin = tracks.album
  where
    album = (
        select
          asin
        from
          albums
        where
          title = 'Blur'
    )

  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  execute(<<-SQL)
  select
    title, count(tracks) as num_tracks
  from
    albums
  join
    tracks on albums.asin = tracks.album
  where
    song LIKE '%Heart%'
  group by
    title
  order by
    count(tracks) desc, title asc
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
  select
    song
  from
    albums
  join
    tracks on albums.asin = tracks.album
  where
    song = title
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
  select
    title
  from
    albums
  join
    tracks on albums.asin = tracks.album
  where
    title = artist
  group by
    title
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
  select song, count(title)
  from tracks join albums on albums.asin = tracks.album
  group by song
  having count(title) > 2
  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
  select title, price, count(tracks)
  from tracks join albums on albums.asin = tracks.album
  group by title, price
  having (price / count(tracks)) < 0.50
  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums in order of track count. Select both the
  # album title and the track count.
  execute(<<-SQL)
  select title, count(song)
  from tracks join albums on albums.asin = tracks.album
  group by title
  order by count(song) desc
  limit 10
  SQL
end

def soundtrack_wars
  # Select the artist who has recorded the most soundtracks, as well as the
  # number of albums. HINT: use LIKE '%Soundtrack%' in your query.
  execute(<<-SQL)
  select artist, count(*)
  from albums join styles on albums.asin = styles.album
  where style like '%Soundtrack%'
  group by artist
  order by count(*) desc
  limit 1
  SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  #
  # HINT: Start by getting the number of tracks per album. You can do this in a
  # subquery. Next, JOIN the styles table to this result and use aggregates to
  # determine the average price per track.

  execute(<<-SQL)
  select distinct style, s1.price/s1.count as average_price
  from (
      select asin,price, count(song)
    from albums join tracks on albums.asin = tracks.album
    where price IS NOT NULL group by asin,price
  ) s1
  join styles on styles.album = s1.asin
  group by style, average_price
  order by average_price desc
  limit 5


  SQL
end
