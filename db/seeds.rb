require 'open-uri'

puts "Cleaning the DB...."
Bookmark.destroy_all
List.destroy_all
User.destroy_all
Movie.destroy_all

# the Le Wagon copy of the API
puts "Creating movies...."
(1..5).to_a.each do |num|
  url = "http://tmdb.lewagon.com/movie/top_rated?page=#{num}"
  response = JSON.parse(URI.open(url).read)

  response['results'].each do |movie_hash|
    Movie.create!(
      poster_url: "https://image.tmdb.org/t/p/w500" + movie_hash['poster_path'],
      rating: movie_hash['vote_average'],
      title: movie_hash['title'],
      overview: movie_hash['overview']
    )
  end
end
puts "... created #{Movie.count} movies."

# ── Users ────────────────────────────────────────────────────────────────────
puts "Creating users...."

alice = User.create!(email: "alice@example.com", password: "password123")
bob   = User.create!(email: "bob@example.com",   password: "password123")

puts "... created #{User.count} users."

# ── Helper: grab a few movies by title fragment ───────────────────────────────
def find_movie(fragment)
  Movie.find_by("title ILIKE ?", "%#{fragment}%")
end

# ── Alice's lists ─────────────────────────────────────────────────────────────
puts "Creating lists and bookmarks...."

# List 1 – Alice: All-Time Classics
classics = alice.lists.create!(name: "All-Time Classics")
photo = URI.parse("https://dnm.nflximg.net/api/v6/2DuQlx0fM4wd1nzqm5BFBi6ILa8/AAAAQaUiPLJpaxXAL-CGwnV-UUKic7arMB-yY4SY7enUbFgSksNG0BClmStlVX4vJO7EIkOODAr7zgP5aO0sPt3iG3XKNVEfbyLY-xQ4bMpzVHHRkSziQ5MnueXkDn4VXT2RfN7C4QEgg-2OvnrRVTfNluW7.jpg?r=936").open
classics.photo.attach(io: photo, filename: "photo.png", content_type: "image/png")
classics.save

[
  { fragment: "Shawshank",    rating: 10, comment: "Perfect in every way – the best film ever made." },
  { fragment: "Godfather",    rating: 10, comment: "Coppola at his absolute peak. A masterclass in storytelling." },
  { fragment: "Schindler",    rating: 9,  comment: "Devastating and important. Spielberg's finest work." },
  { fragment: "Dark Knight",  rating: 10, comment: "Ledger's Joker alone makes this a must-see for life." },
  { fragment: "Inception",    rating: 9,  comment: "Mind-bending and visually spectacular." },
].each do |entry|
  movie = find_movie(entry[:fragment])
  next unless movie
  classics.bookmarks.create!(movie: movie, rating: entry[:rating], comment: entry[:comment])
end

# List 2 – Alice: Sci-Fi Picks
scifi = alice.lists.create!(name: "Sci-Fi Picks")
[
  { fragment: "Interstellar", rating: 9, comment: "The docking scene alone is worth 10 stars." },
  { fragment: "2001",         rating: 8, comment: "Kubrick redefined the genre forever." },
  { fragment: "Matrix",       rating: 9, comment: "Nothing felt the same after watching this." },
].each do |entry|
  movie = find_movie(entry[:fragment])
  next unless movie
  scifi.bookmarks.create!(movie: movie, rating: entry[:rating], comment: entry[:comment])
end

# ── Bob's lists ───────────────────────────────────────────────────────────────

# List 3 – Bob: Action Favorites
action = bob.lists.create!(name: "Action Favorites")
photo = URI.parse("https://deadline.com/wp-content/uploads/2025/05/Rambo-First-Blood.webp?w=681&h=383&crop=1").open
action.photo.attach(io: photo, filename: "photo.png", content_type: "image/png")
action.save

[
  { fragment: "Gladiator",    rating: 9, comment: "Russell Crowe is unstoppable. Great from start to finish." },
  { fragment: "Mad Max",      rating: 8, comment: "Pure adrenaline – an action masterpiece." },
  { fragment: "John Wick",    rating: 8, comment: "The choreography is insane. Every scene is electric." },
].each do |entry|
  movie = find_movie(entry[:fragment])
  next unless movie
  action.bookmarks.create!(movie: movie, rating: entry[:rating], comment: entry[:comment])
end

# List 4 – Bob: Weekend Dramas
dramas = bob.lists.create!(name: "Weekend Dramas")
[
  { fragment: "Forrest Gump",   rating: 9, comment: "Cried twice. Laughed more. Absolutely wonderful." },
  { fragment: "Green Mile",     rating: 9, comment: "Powerful storytelling with unforgettable characters." },
  { fragment: "Whiplash",       rating: 10, comment: "The tension never lets up. Fletcher is terrifying." },
].each do |entry|
  movie = find_movie(entry[:fragment])
  next unless movie
  dramas.bookmarks.create!(movie: movie, rating: entry[:rating], comment: entry[:comment])
end

puts "... created #{List.count} lists with #{Bookmark.count} bookmarks."
puts "Done! Sign in with alice@example.com or bob@example.com (password: password123)"
