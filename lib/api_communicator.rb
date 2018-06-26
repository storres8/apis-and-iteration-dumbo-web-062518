require 'rest-client'
require 'json'
require 'pry'



def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  character_array = character_hash["results"]
  found_character = character_array.find do |the_character|
    the_character["name"].downcase == character
    binding.pry
  end
  the_URLs_array = found_character["films"]

  movies_array = []
  the_URLs_array.each do |url|
  movies_array << JSON.parse(RestClient.get(url))
end
return movies_array
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end


def parse_character_movies(films_hash)
  relevant_stuff = ["title", "episode id", "producer", "director", "release date"]

  films_hash.map do |movie_hash|
    movie_hash.map do |key, detail|
      relevant_stuff.each do |category|
        if key == category
          print key.sub("_", " ")
          print ": "
          puts detail
          puts "" if key == "producer"
        end
      end
    end
  end
end

# Luke_movie_hash = get_character_movies_from_api("Luke Skywalker")
# parse_character_movies(Luke_movie_hash)


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
