# WatchList

A movie watchlist app built with Ruby on Rails. Users can sign up, create personal movie lists, and save movies with their own ratings and notes.

## Features

- User authentication (sign up, sign in, sign out) via Devise
- Create and delete personal movie lists with optional cover photos
- Browse a catalogue of movies seeded from the TMDB API
- Save movies to lists with a personal rating (1–10) and optional note
- Edit or remove saved movies from a list
- Responsive design — works on mobile and desktop
- Dark cinema-themed UI with custom Bootstrap modal confirmations

## Tech Stack

- **Ruby on Rails 8** — MVC framework
- **PostgreSQL** — database
- **Devise** — user authentication
- **Active Storage + Cloudinary** — list cover photo uploads
- **Bootstrap 5.3 + Font Awesome 6** — UI and icons
- **Simple Form** — form helpers
- **Hotwire (Turbo + Stimulus)** — SPA-like navigation without a JS framework
- **Import Maps** — JS module management (no Node/webpack)

## Data Model

```
User ──< List ──< Bookmark >── Movie
```

- **User** — authenticates via Devise, owns many lists
- **Movie** — seeded from TMDB, has title, overview, poster, and rating
- **List** — belongs to a user, has a name and optional Cloudinary cover photo
- **Bookmark** — join model between List and Movie; adds a user rating (1–10) and an optional comment

## Setup

```bash
git clone https://github.com/sp1aca9fa/rails-watch-list.git
cd rails-watch-list
bundle install
```

Create a `.env` file with your Cloudinary credentials (required for cover photo uploads):

```
CLOUDINARY_URL=cloudinary://<api_key>:<api_secret>@<cloud_name>
```

Set up the database and start the server (seeding fetches ~100 movies from TMDB, so an internet connection is required):

```bash
rails db:create db:migrate db:seed
rails server
```

Open [http://localhost:3000](http://localhost:3000) in your browser. Two sample accounts are created by the seed:

| Email | Password |
|---|---|
| alice@example.com | password123 |
| bob@example.com | password123 |

## Notes

Started as a Le Wagon bootcamp challenge focused on many-to-many relationships. Extended with authentication, user ratings, a full visual overhaul, and responsive mobile support.
