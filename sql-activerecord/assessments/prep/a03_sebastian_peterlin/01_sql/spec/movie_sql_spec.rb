# -*- coding: utf-8 -*-
require 'rspec'
require 'movie_sql'

describe do
  it "1. List 'Rain Man' cast by name" do
    expect(rain_man_cast).to eq([
      {"name"=>"Barry Levinson"},
      {"name"=>"Bonnie Hunt"},
      {"name"=>"Dustin Hoffman"},
      {"name"=>"Jack Murdock"},
      {"name"=>"Jerry Molen"},
      {"name"=>"Lucinda Jenney"},
      {"name"=>"Michael D. Roberts"},
      {"name"=>"Tom Cruise"},
      {"name"=>"Valeria Golino"}
    ])
  end

  it "2. List Denzel Washington supporting films by movie title" do
    expect(denzel_washington_non_starring_films).to eq([
      {"title"=>"Glory"},
      {"title"=>"Much Ado About Nothing"},
      {"title"=>"Philadelphia"}
    ])
  end

  it "3. List Christopher Walken 21st century films by movie title" do
    expect(christopher_walken_21st_century_films).to eq([
      {"title"=>"Balls of Fury", "yr"=>2007},
      {"title"=>"Catch Me If You Can", "yr"=>2002},
      {"title"=>"Click", "yr"=>2006},
      {"title"=>"Envy", "yr"=>2004},
      {"title"=>"Gigli", "yr"=>2003},
      {"title"=>"Joe Dirt", "yr"=>2001},
      {"title"=>"Man On Fire", "yr"=>2004},
      {"title"=>"Man of the Year", "yr"=>2006},
      {"title"=>"The Country Bears", "yr"=>2002},
      {"title"=>"The Rundown", "yr"=>2003},
      {"title"=>"The Stepford Wives", "yr"=>2004},
      {"title"=>"Wedding Crashers", "yr"=>2005}
    ])
  end

  it "4. List 1906-1908 films and leading stars by movie title" do
    expect(old_films_and_their_star).to eq([
      {"title"=>"After Many Years", "star"=>"Florence Lawrence"},
      {"title"=>"His Wife's Child", "star"=>"Florence Lawrence"},
      {"title"=>"L'Assassinat du Duc de Guise", "star"=>"Henri III"},
      {"title"=>"L'Enfant prodigue", "star"=>"Georges Wague"},
      {"title"=>"Macbeth", "star"=>"William Ranous"},
      {"title"=>"Rescued from an Eagle's Nest", "star"=>"D. W. Griffith"},
      {"title"=>"The Adventures of Dollie", "star"=>"Arthur V. Johnson"},
      {"title"=>"The Fairylogue and Radio-Plays", "star"=>"L. Frank Baum"},
      {"title"=>"The Story of the Kelly Gang", "star"=>"Nicholas Brierley"},
      {"title"=>"The Taming of the Shrew", "star"=>"Florence Lawrence"}
    ])
  end

  it "5. Give the movie from 1920 with no casting information" do
    expect(no_casting_info).to eq([
      {"title"=>"The Mark of Zorro"}
    ])
  end

  it "6. List titles that have been used more than 3 times by movie title" do
    expect(duplicate_titles).to eq([
      {"title"=>"Alice in Wonderland", "num_of_productions"=>4},
      {"title"=>"Alraune", "num_of_productions"=>4},
      {"title"=>"Dr. Jekyll and Mr. Hyde", "num_of_productions"=>6},
      {"title"=>"Dracula", "num_of_productions"=>4},
      {"title"=>"Oliver Twist", "num_of_productions"=>4},
      {"title"=>"The Hunchback of Notre Dame", "num_of_productions"=>4}
    ])
  end

  it "7. List the title and star of films with 70 or more roles, by title" do
    expect(big_movie_stars).to eq([
      {"title"=>"A Hundred and One Nights", "name"=>"Michel Piccoli"},
      {"title"=>"Perfect", "name"=>"John Travolta"}
    ])
  end

  it "8. List movies and stars supported by Ben Affleck, by movie title" do
    expect(stars_working_with_ben_affleck).to eq([
      {"title"=>"Armageddon", "name"=>"Bruce Willis"},
      {"title"=>"Boiler Room", "name"=>"Giovanni Ribisi"},
      {"title"=>"Buffy the Vampire Slayer", "name"=>"Kristy Swanson"},
      {"title"=>"Dazed and Confused", "name"=>"Jason London"},
      {"title"=>"Glory Road", "name"=>"Josh Lucas"},
      {"title"=>"Good Will Hunting", "name"=>"Matt Damon"},
      {"title"=>"Hollywoodland", "name"=>"Adrien Brody"}
    ])
  end
end
