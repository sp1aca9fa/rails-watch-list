# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
puts "Cleaning the DB...."
Movie.destroy_all
# List.destroy_all

# the Le Wagon copy of the API
puts "Creating movies.... \n"
(1..5).to_a.each do |num|
  url = "http://tmdb.lewagon.com/movie/top_rated?page=#{num}"
  response = JSON.parse(URI.open(url).read)

  response['results'].each do |movie_hash|
    puts "...creating the movie #{movie_hash['title']}..."
    puts
    # create an instance with the hash
    Movie.create!(
      poster_url: "https://image.tmdb.org/t/p/w500" + movie_hash['poster_path'],
      rating: movie_hash['vote_average'],
      title: movie_hash['title'],
      overview: movie_hash['overview']
    )
  end
end
puts "... created #{Movie.count} movies."

puts "Creating lists... \n"

list = List.create(name: 'Comedy')
photo = URI.parse("https://dnm.nflximg.net/api/v6/2DuQlx0fM4wd1nzqm5BFBi6ILa8/AAAAQaUiPLJpaxXAL-CGwnV-UUKic7arMB-yY4SY7enUbFgSksNG0BClmStlVX4vJO7EIkOODAr7zgP5aO0sPt3iG3XKNVEfbyLY-xQ4bMpzVHHRkSziQ5MnueXkDn4VXT2RfN7C4QEgg-2OvnrRVTfNluW7.jpg?r=936").open
list.photo.attach(io: photo, filename: "photo.png", content_type: "image/png")
list.save

list = List.create(name: 'Action')
photo = URI.parse("https://deadline.com/wp-content/uploads/2025/05/Rambo-First-Blood.webp?w=681&h=383&crop=1").open
list.photo.attach(io: photo, filename: "photo.png", content_type: "image/png")
list.save

puts "... created 2 lists."
