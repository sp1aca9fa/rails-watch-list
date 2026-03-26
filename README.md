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
- ERB (Embedded Ruby)
- Bootstrap & Font Awesome (for styling)
- Simple Form (for form handling)
- RSpec (for testing)

## Data Model

- **Movie**
  - title
  - overview
  - poster_url
  - rating

- **List**
  - name

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
git clone <your-repo-url>
cd rails-watch-list
bundle install
rails db:create db:migrate db:seed
rails server
```

Run tests:

```bash
rspec
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
