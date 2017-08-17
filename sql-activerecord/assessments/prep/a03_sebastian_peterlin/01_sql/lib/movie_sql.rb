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

# 1. Obtain the cast list for the movie 'Rain Man'; order by the actors'
#    names.
def rain_man_cast
  MovieDatabase.execute(<<-SQL)
  select name
  from casting
  join actor on casting.actorid = actor.id
  join movie on casting.movieid = movie.id
  where movie.title = 'Rain Man'
  order by name
SQL
end

# 2. List the films in which 'Denzel Washington' has appeared, but not
#    in the leading role. Order by movie title.
def denzel_washington_non_starring_films
  MovieDatabase.execute(<<-SQL)
  select title
  from casting
  join actor on casting.actorid = actor.id
  join movie on casting.movieid = movie.id
  where ord !=1 and actor.name = 'Denzel Washington'
  order by title
SQL
end

# 3. For each film released in 2000 or later in which 'Christopher
#    Walken' has appeared, list the movie title and the year. Order by
#    movie title.
def christopher_walken_21st_century_films
  MovieDatabase.execute(<<-SQL)
  select title, yr
  from casting
  join actor on casting.actorid = actor.id
  join movie on casting.movieid = movie.id
  where yr >= 2000 and name = 'Christopher Walken'
  order by title

SQL
end

# 4. List the films together with the leading star for all films
#    produced between 1906 and 1908 (inclusive). Order by movie title,
#    and label the actors as 'star'.
def old_films_and_their_star
  MovieDatabase.execute(<<-SQL)
  select title, name as star
  from casting
  join actor on casting.actorid = actor.id
  join movie on casting.movieid = movie.id
  where (yr between 1906 and 1908) and ord = 1
  order by title
SQL
end

# 5. There is a movie from 1920 in our database for which there is no
#    associated casting information. Give the title of this movie.
def no_casting_info
  MovieDatabase.execute(<<-SQL)
  select title
  from movie
  -- join actor on casting.actorid = actor.id
  left outer join casting on casting.movieid = movie.id
  where yr = 1920 and movieid is null
SQL
end

# 6. Some film titles have been re-used several times. List the movie
#    titles and 'num_of_productions' for each title that has been used
#    more than 3 times. Order by title.
def duplicate_titles
  MovieDatabase.execute(<<-SQL)
  select title, count(*) as num_of_productions
  from movie
  group by title
  having count(*) > 3
  order by title
  SQL
end

# 7. List the movie title and starring actor (ord = 1) for films with 70
#    or more cast members. Order by movie title.
def big_movie_stars
  MovieDatabase.execute(<<-SQL)
  select title, name, count(actorid)
  from casting join movie on movie.id = casting.movieid
  join actor on actor.id = casting.actorid
  where ord = 1s
  group by title
  having count(actorid) >= 70
SQL
end

# 8. List the movie title and the leading actor for all of the films
#    in which 'Ben Affleck' appeared but not as the lead actor.
def stars_working_with_ben_affleck
  MovieDatabase.execute(<<-SQL)
  select title, name
  from casting
  join actor on casting.actorid = actor.id
  join movie on casting.movieid = movie.id
  where ord = 1 and movie.id in (
      select movie.id
      from casting
      join actor on casting.actorid = actor.id
      join movie on casting.movieid = movie.id
      where name = 'Ben Affleck' and ord != 1
  )
SQL
end
