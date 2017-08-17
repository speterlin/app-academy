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
  SELECT
    actor.name
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON casting.movieid = movie.id
  WHERE
    movie.title = 'Rain Man'
  ORDER BY
    actor.name
SQL
end

# 2. List the films in which 'Denzel Washington' has appeared, but not
#    in the leading role. Order by movie title.
def denzel_washington_non_starring_films
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.title
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON casting.movieid = movie.id
  WHERE
    actor.name = 'Denzel Washington' AND ord != 1
  ORDER BY
    movie.title
SQL
end

# 3. For each film released in 2000 or later in which 'Christopher
#    Walken' has appeared, list the movie title and the year. Order by
#    movie title.
def christopher_walken_21st_century_films
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.title, movie.yr
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON casting.movieid = movie.id
  WHERE
    actor.name = 'Christopher Walken' AND yr >= 2000
  ORDER BY
    movie.title
SQL
end

# 4. List the films together with the leading star for all films
#    produced between 1906 and 1908 (inclusive). Order by movie title,
#    and label the actors as 'star'.
def old_films_and_their_star
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.title, actor.name AS star
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON casting.movieid = movie.id
  WHERE
    (movie.yr BETWEEN 1906 AND 1908) AND casting.ord = 1
  ORDER BY
    movie.title
SQL
end

# 5. There is a movie from 1920 in our database for which there is no
#    associated casting information. Give the title of this movie.
def no_casting_info
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.title
  FROM
    movie
  LEFT OUTER JOIN
    casting ON movie.id = casting.movieid
  WHERE
    movie.yr = 1920 AND casting.movieid IS NULL
  ORDER BY
    movie.title
SQL
end

# 6. Some film titles have been re-used several times. List the movie
#    titles and 'num_of_productions' for each title that has been used
#    more than 3 times. Order by title.
def duplicate_titles
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.title, COUNT(movie.id) AS num_of_productions
  FROM
    movie
  GROUP BY
    movie.title
  HAVING
    COUNT(movie.id) > 3
  ORDER BY
    movie.title
SQL
end

# 7. List the movie title and starring actor (ord = 1) for films with 70
#    or more cast members. Order by movie title.
def big_movie_stars
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.title, actor.name
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON casting.movieid = movie.id
  WHERE
    casting.ord = 1 AND movie.id IN
    (
      SELECT
        movie.id
      FROM
        casting
      JOIN
        movie ON casting.movieid = movie.id
      GROUP BY
        casting.movieid
      HAVING
        COUNT(casting.movieid) >= 70
    )
  ORDER BY
    movie.title
SQL
end

# 8. List the movie title and the leading actor for all of the films
#    in which 'Ben Affleck' appeared but not as the lead actor.
def stars_working_with_ben_affleck
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.title, actor.name
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON casting.movieid = movie.id
  WHERE
    casting.ord = 1 AND movie.id IN (
      SELECT
        ben_movie.id
      FROM
        actor AS ben_actor
      JOIN
        casting AS ben_casting ON ben_actor.id = ben_casting.actorid
      JOIN
        movie AS ben_movie ON ben_casting.movieid = ben_movie.id
      WHERE
        ben_actor.name = 'Ben Affleck' AND ben_casting.ord > 1
    )
  ORDER BY
    movie.title

  /*
  Alternate solution, using only joins and no subquery:
  SELECT
    movie.title, lead_actor.name
  FROM
    actor AS ben_actor
  JOIN
    casting AS ben_casting ON ben_actor.id = ben_casting.actorid
  JOIN
    movie ON ben_casting.movieid = movie.id
  JOIN
    casting AS lead_casting ON movie.id = lead_casting.movieid
  JOIN
    actor AS lead_actor ON lead_casting.actorid = lead_actor.id
  WHERE
    ben_actor.name = 'Ben Affleck' AND
      ben_casting.ord > 1 AND
      lead_casting.ord = 1
  ORDER BY
    movie.title
  */
SQL
end
