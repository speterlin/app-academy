require 'singleton'
require 'sqlite3'

class MovieDatabase < SQLite3::Database
  include Singleton

  def initialize
    super(File.dirname(__FILE__) + "/../movie.db")

    self.results_as_hash = true
    self.type_translation = true
  end

  def self.execute(*args)
    self.instance.execute(*args)
  end
end

# List the films in which 'Chuck Norris' has appeared; order by movie
# title.
def bearded_films
  MovieDatabase.execute(<<-SQL)
  select title
  from casting
  join actor on casting.actorid = actor.id
  join movie on casting.movieid = movie.id
  where actor.id = (
        select id
        from actor
        where name = 'Chuck Norris'
  )
  SQL
end

# Obtain the cast list for the movie "Zombies of the Stratosphere";
# order by the actor's name.
def zombie_cast
  MovieDatabase.execute(<<-SQL)
  select name
  from casting
  join actor on casting.actorid = actor.id
  -- join movie on casting.movieid = movie.id
  where movieid = (
      select id
      from movie
      where title = 'Zombies of the Stratosphere'
  )
  order by name asc
  SQL
end

# Which were the busiest years for 'Danny DeVito'? Show the year and
# the number of movies he acted in for any year in which he was part of
# >2 movies. Order by year. Note the 'V' is capitalized.
def biggest_years_for_little_danny
  MovieDatabase.execute(<<-SQL)
  select yr, count() as count
  from casting
  join actor on casting.actorid = actor.id
  join movie on casting.movieid = movie.id
  where actor.name = 'Danny DeVito'
  group by yr
  having count > 2
  SQL
end

# List the films where 'Nicolas Cage' has appeared, but not in the
# star role. Order by movie title.
def more_cage_please
  MovieDatabase.execute(<<-SQL)
  select title
  from casting
  join actor on casting.actorid = actor.id
  join movie on casting.movieid = movie.id
  where actor.name = 'Nicolas Cage' and ord != 1
  order by movie.title
  SQL
end

# List the films together with the leading star for all 1908
# films. Order by movie title.
def who_is_florence_lawrence
  MovieDatabase.execute(<<-SQL)
  select title, name
  from casting
  join actor on casting.actorid = actor.id
  join movie on casting.movieid = movie.id
  where ord = 1 and yr = 1908
  order by movie.title
  SQL
end

# Some actors listed in our database are not associated with any actual
# movie role(s). How many such actors are there? Alias this number as
# 'num_bad_actors'.
def count_bad_actors
  MovieDatabase.execute(<<-SQL)
  select count(*) as num_bad_actors
  from actor
  left outer join casting on casting.actorid = actor.id
  where movieid is null
SQL
end

# Obtain a list in alphabetical order of actors who've had exactly 20
# starring roles. Order by actor name.
def twenty_roles
  MovieDatabase.execute(<<-SQL)
  select name
  from casting
  join actor on casting.actorid = actor.id
  where ord = 1
  group by name
  having count(movieid) = 20
  order by actor.name
  SQL
end

# List the film title and the leading actor for all of the films
# 'Chris Farley' played in.
def chris_is_missed
  MovieDatabase.execute(<<-SQL)
  select title, actor.name
  from casting
  join actor on casting.actorid = actor.id
  join movie on casting.movieid = movie.id
  where ord = 1 and movieid in (
      select movie.id
      from casting
      join actor on casting.actorid = actor.id
      join movie on casting.movieid = movie.id
      where actor.name = 'Chris Farley'
  )
  order by title
  SQL
end
