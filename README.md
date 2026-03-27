# Rails Watch List

A movie watchlist application built with Ruby on Rails where users can create lists and save movies through bookmarks.

## Features

- Create and manage movie lists
- View list details with associated movies
- Add movies to lists via bookmarks
- Remove movies from lists

## Tech Stack

- Ruby on Rails
- PostgreSQL
- Active Record (ORM)
- Active Storage + Cloudinary (for list photo uploads)
- ERB (Embedded Ruby)
- Bootstrap & Font Awesome (for styling)
- Simple Form (for form handling)

## Data Model

- **Movie**
  - title
  - overview
  - poster_url
  - rating

- **List**
  - name
  - photo (Active Storage attachment)

- **Bookmark**
  - comment
  - belongs to a movie
  - belongs to a list

## How It Works

- Movies are pre-seeded in the database
- Users create custom lists to organize movies
- Bookmarks act as a join model between movies and lists
- Active Record associations manage many-to-many relationships
- Validations ensure data consistency (e.g., unique pairings, comment length)

## Setup

```bash
git clone https://github.com/sp1aca9fa/rails-watch-list.git
cd rails-watch-list
bundle install
```

Create a `.env` file in the project root with your Cloudinary credentials (required for list photo uploads):

```
CLOUDINARY_URL=cloudinary://<api_key>:<api_secret>@<cloud_name>
```

Then set up the database and start the server (seeding fetches movies from an external API, so an internet connection is required):

```bash
rails db:create db:migrate db:seed
rails server
```

Open in your browser:
http://localhost:3000/lists

## Learnings

- Designing and implementing many-to-many relationships
- Using join models with Active Record
- Structuring multi-model Rails applications
- Enforcing data integrity with validations
- Managing nested resources and associations

## Notes

This project is a solution to a Le Wagon bootcamp challenge focused on building a multi-model Rails application with many-to-many relationships and structured data modeling.
