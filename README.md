snap-web

Rails application scaffold for the "snap" project.

This repository is a modern Rails 8 app (Propshaft assets, esbuild for JS, sass for CSS) using PostgreSQL and Sidekiq for background jobs. It includes production-focused Docker artifacts and a Render deploy configuration.

## Table of Contents

- [At a glance](#at-a-glance)
- [Prerequisites](#prerequisites)
- [Quick local setup](#quick-local-setup)
- [Tests](#tests)
- [Docker](#docker)
- [Production & Deployment](#production--deployment)
- [Asset compilation](#asset-compilation)
- [Background jobs](#background-jobs)
- [Helpful files](#helpful-files)
- [Contributing](#contributing)
- [Contact / Maintainers](#contact--maintainers)

## At a glance

- Rails: ~> 8.0.3 (Gemfile)
- Ruby (recommended): 3.4.2 (matches Dockerfile ARG RUBY_VERSION)
- Node: 22.20.0 and Yarn 1.22.22 are used in the Dockerfile build stage
- DB: PostgreSQL
- App server: Puma (default) / Thruster used in Docker CMD
- Background jobs: Sidekiq
- JS bundler: esbuild (scripts in `package.json`)

## Prerequisites

- Install a Ruby manager (rbenv, rvm, chruby). Use Ruby 3.4.2 to match the Dockerfile.
- Install Bundler (gem install bundler).
- Install Node (v22.x recommended) and Yarn (v1.x) if running assets locally.
- PostgreSQL (local dev DB) or access to a PostgreSQL instance.
- For image processing: `libvips` is used in the Dockerfile; install it locally if you need the same capabilities.

## Quick local setup

1. Clone the repo:

```bash
git clone <repo-url> snap-web
cd snap-web
```

2. Install Ruby and set the correct version (example using rbenv):

```bash
rbenv install 3.4.2
rbenv local 3.4.2
gem install bundler
```

3. Install gems and JS dependencies:

```bash
bundle install
yarn install
```

4. Create and prepare the database:

```bash
bin/rails db:create db:migrate db:seed
```

5. Build assets (one-time for production-style build):

```bash
yarn build
yarn build:css
```

6. Run the app in development (recommended approach: use `Procfile.dev` to run multiple processes). The repository includes a `Procfile.dev` with common dev processes. Use a Procfile manager such as `foreman`, `heroku local`, or `overmind`.

Example using `foreman`:

```bash
# install foreman (if you don't have it)
gem install foreman
foreman start -f Procfile.dev
```

This will start the Rails web server, js/css watchers and Sidekiq worker as defined in `Procfile.dev`:

- web: `env RUBY_DEBUG_OPEN=true bin/rails server`
- js: `yarn build --watch`
- css: `yarn build:css --watch`
- worker: `bundle exec sidekiq`

Alternatively run just the web server for quick iteration:

```bash
bin/rails server
```

To run Sidekiq separately:

```bash
bundle exec sidekiq
```

## Tests

Run the Rails test suite (the project uses the default Rails testing tools unless otherwise configured):

```bash
bin/rails test
```

If the repository adds RSpec later, use `bundle exec rspec`.

## Docker

The provided `Dockerfile` is intended for production builds. Basic build/run example:

```bash
# build
docker build -t snap .

# run (you must provide RAILS_MASTER_KEY env value from config/master.key)
docker run -d -p 80:80 -e RAILS_MASTER_KEY=<your_master_key> --name snap snap
```

Notes:

- The Dockerfile uses a multi-stage build and sets `RUBY_VERSION=3.4.2` by default.
- The image expects `RAILS_MASTER_KEY` at runtime for credentials access.

## Production & Deployment

- Kamal is included in the Gemfile and can be used for Docker/cluster deployments.
- A `render.yaml` is included for deploying to Render.com. The Render configuration expects:
  - a managed PostgreSQL database (the `render.yaml` references `snap-db`)
  - the `RAILS_MASTER_KEY` set in the Render environment variables (sync: false — set manually in the Render dashboard)

Render build/start configuration (from `render.yaml`):

- buildCommand: `./bin/render-build.sh`
- startCommand: `./bin/rails server`

When deploying anywhere, ensure:

- `RAILS_MASTER_KEY` is provided by your hosting environment
- Database credentials / `DATABASE_URL` are configured
- `WEB_CONCURRENCY` / process scaling are tuned for your plan

## Asset compilation

Two primary npm scripts are available in `package.json`:

- `yarn build` — builds JS via esbuild into `app/assets/builds` (production bundle)
- `yarn build:css` — builds CSS (sass -> CSS)

For development use the watch modes in `Procfile.dev`.

## Background jobs

Sidekiq is used for background processing. Start it with:

```bash
bundle exec sidekiq
```

Make sure Redis is available if Sidekiq is configured to use it (check `config/sidekiq.yml` or environment).

## Helpful files

- `Gemfile` — Ruby dependencies
- `package.json` — JS/CSS build scripts & dependencies
- `Dockerfile` — production container image
- `Procfile.dev` — processes for local development
- `render.yaml` — Render.com service definition

## Contributing

Please open issues or PRs for bugs and feature requests. If you plan to work on larger changes, open an issue first so we can discuss the approach.

## Contact / Maintainers

See repository maintainers via the hosting service or look in `CONTRIBUTING.md` if present.

---

If you'd like, I can also:

- add a short `bin/setup` script to automate local setup (bundle/yarn/db tasks), or
- add a `Makefile` with common commands to simplify developer onboarding.

Tell me which of those you'd like next and I can implement it (no code changes to core app unless you ask).
snap-web

Rails application scaffold for the "snap" project.

This repository is a modern Rails 8 app (Propshaft assets, esbuild for JS, sass for CSS) using PostgreSQL and Sidekiq for background jobs. It includes production-focused Docker artifacts and a Render deploy configuration.

## Table of Contents

- [At a glance](#at-a-glance)
- [Prerequisites](#prerequisites)
- [Quick local setup](#quick-local-setup)
- [Tests](#tests)
- [Docker](#docker)
- [Production & Deployment](#production--deployment)
- [Asset compilation](#asset-compilation)
- [Background jobs](#background-jobs)
- [Helpful files](#helpful-files)
- [Contributing](#contributing)
- [Contact / Maintainers](#contact--maintainers)

## At a glance

- Rails: ~> 8.0.3 (Gemfile)
- Ruby (recommended): 3.4.2 (matches Dockerfile ARG RUBY_VERSION)
- Node: 22.20.0 and Yarn 1.22.22 are used in the Dockerfile build stage
- DB: PostgreSQL
- App server: Puma (default) / Thruster used in Docker CMD
- Background jobs: Sidekiq
- JS bundler: esbuild (scripts in `package.json`)

## Prerequisites

- Install a Ruby manager (rbenv, rvm, chruby). Use Ruby 3.4.2 to match the Dockerfile.
- Install Bundler (gem install bundler).
- Install Node (v22.x recommended) and Yarn (v1.x) if running assets locally.
- PostgreSQL (local dev DB) or access to a PostgreSQL instance.
- For image processing: `libvips` is used in the Dockerfile; install it locally if you need the same capabilities.

## Quick local setup

1. Clone the repo:

```bash
git clone <repo-url> snap-web
cd snap-web
```

2. Install Ruby and set the correct version (example using rbenv):

```bash
rbenv install 3.4.2
rbenv local 3.4.2
gem install bundler
```

3. Install gems and JS dependencies:

```bash
bundle install
yarn install
```

4. Create and prepare the database:

```bash
bin/rails db:create db:migrate db:seed
```

5. Build assets (one-time for production-style build):

```bash
yarn build
yarn build:css
```

6. Run the app in development (recommended approach: use `Procfile.dev` to run multiple processes). The repository includes a `Procfile.dev` with common dev processes. Use a Procfile manager such as `foreman`, `heroku local`, or `overmind`.

Example using `foreman`:

```bash
# install foreman (if you don't have it)
gem install foreman
foreman start -f Procfile.dev
```

This will start the Rails web server, js/css watchers and Sidekiq worker as defined in `Procfile.dev`:

- web: `env RUBY_DEBUG_OPEN=true bin/rails server`
- js: `yarn build --watch`
- css: `yarn build:css --watch`
- worker: `bundle exec sidekiq`

Alternatively run just the web server for quick iteration:

```bash
bin/rails server
```

To run Sidekiq separately:

```bash
bundle exec sidekiq
```

## Tests

Run the Rails test suite (the project uses the default Rails testing tools unless otherwise configured):

```bash
bin/rails test
```

If the repository adds RSpec later, use `bundle exec rspec`.

## Docker

The provided `Dockerfile` is intended for production builds. Basic build/run example:

```bash
# build
docker build -t snap .

# run (you must provide RAILS_MASTER_KEY env value from config/master.key)
docker run -d -p 80:80 -e RAILS_MASTER_KEY=<your_master_key> --name snap snap
```

Notes:

- The Dockerfile uses a multi-stage build and sets `RUBY_VERSION=3.4.2` by default.
- The image expects `RAILS_MASTER_KEY` at runtime for credentials access.

## Production & Deployment

- Kamal is included in the Gemfile and can be used for Docker/cluster deployments.
- A `render.yaml` is included for deploying to Render.com. The Render configuration expects:
  - a managed PostgreSQL database (the `render.yaml` references `snap-db`)
  - the `RAILS_MASTER_KEY` set in the Render environment variables (sync: false — set manually in the Render dashboard)

Render build/start configuration (from `render.yaml`):

- buildCommand: `./bin/render-build.sh`
- startCommand: `./bin/rails server`

When deploying anywhere, ensure:

- `RAILS_MASTER_KEY` is provided by your hosting environment
- Database credentials / `DATABASE_URL` are configured
- `WEB_CONCURRENCY` / process scaling are tuned for your plan

## Asset compilation

Two primary npm scripts are available in `package.json`:

- `yarn build` — builds JS via esbuild into `app/assets/builds` (production bundle)
- `yarn build:css` — builds CSS (sass -> CSS)

For development use the watch modes in `Procfile.dev`.

## Background jobs

Sidekiq is used for background processing. Start it with:

```bash
bundle exec sidekiq
```

Make sure Redis is available if Sidekiq is configured to use it (check `config/sidekiq.yml` or environment).

## Helpful files

- `Gemfile` — Ruby dependencies
- `package.json` — JS/CSS build scripts & dependencies
- `Dockerfile` — production container image
- `Procfile.dev` — processes for local development
- `render.yaml` — Render.com service definition

## Contributing

Please open issues or PRs for bugs and feature requests. If you plan to work on larger changes, open an issue first so we can discuss the approach.

## Contact / Maintainers

See repository maintainers via the hosting service or look in `CONTRIBUTING.md` if present.

---
