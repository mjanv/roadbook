# Roadbook

[**Live demo - Fly.io**](https://roadbook.fly.dev/) • [**Local application**](https://localhost:4001) • [**Local notebooks**](http://localhost:8080)

*Roadbook* is a tool to help route planner ([Komoot](https://www.komoot.com), [Strava](https://www.strava.com), ...) users to create elevation maps from a GPS track.

- When a cyclist sees the trace of a stage, he can see **climb profiles** such as [example #1](https://climbfinder.com/en/climbs/alpe-d-huez) or [example #2](https://www.cols-cyclisme.com/vanoise/france/col-de-la-loze-depuis-brides-les-bains-c3612.htm) that breaks down mountain pass kilometer per kilometer with the percentage elevation per kilometer.
- When a cyclist uses a route planner such as Komoot, he can have the UI representation of the full route with the total elevation and the full profile, but no climbs breakdown.

This application builds a full roadbook (all climbs profiles) for a given route.

## Development

To develop, you need to have [just](https://github.com/casey/just), [docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/) installed.

### Local development

To run the web application for local development,

```bash
just server
```

### Notebooks

To help develop the application, you can use the notebooks accessible in the `notebooks/` folder. Any notebook can be displayed using the [local livebook](http://localhost:8080/open/file),

```bash
just notebooks
```

### Tests

To ensure that code quality and unit tests requirements are met,

```bash
just start
just tests
```

### Local demonstration

To run the full application stack (Application, Livebook, [Grafana](http://localhost:3000)) for demonstration purposes,

```bash
just app
```

### Local demonstration

All stacks (development, notebooks, demonstration) can be stopped using,

```bash
just stop
```

## Roadmap

### Core

- [ ] GPX file can be stored in a PostGIS table and extracted as GeoJson for web representation
- [x] Unit tests for climbs profile object are written
- [ ] A first climb profile dataset is available
- [ ] A climb profile can be computed and stored alongside a stage at creation or update
- [ ] PDF files can be generated from HTML templates and a list of climbs profiles
- [x] Domain events can be stored and read in events store(s)
- [x] Event-driven agents can subcribe to event streams

### Search

- [ ] Climbs are searchable by name, elevation, average slop, or start/stop name
- [ ] Related climbs (by geographical distance or elevation/distance/profile ) can be found
- [ ] Write a climb research engine to filter climbs by name, elevation, average slope or start/stop

### Web

- [x] User accounts can be created from a registration page
- [ ] Users can create accounts from Komoot or Strava Oauth2 authentification
- [x] Users can log in or out
- [ ] The homepage is an infinite map displaying availables climbs
- [ ] An HTML5 graph can be generated from a climb profile
- [ ] Climbs profiles graphs can be rerendered from users inputs
- [ ] An user can drag&drop an GPX file to the server
- [ ] When a user submits a GPX file,
  - [ ] the track is displayed onto a map
  - [ ] the track is analyzed to find all climbs profiles
  - [ ] all climbs profiles are displayed besides the map
- [ ] A [command palette](https://tailwindui.com/components/application-ui/navigation/command-palettes) is available on the homepage to search through climbs, stages,...

### Notifications

- [x] Users can be notified by through email
- [ ] Administrators can be notified through Telegram

### Providers

- [ ] GPX file dump from Strava planner is available
- [x] Climbs profile dataset from [Cols Cyclisme](https://www.cols-cyclisme.com) can be extracted
- [ ] From a given climb dataset, start and stop locations of each climb can be extracted
- [ ] Climb profile data from can be extracted from OpenStreetMap using the start and stop locations descriptions

### Release

- [x] Code quality is evaluated by Dialyzer
- [x] A developer documentation can be built from source code
- [x] Github actions are used to test the quality, run the unit tests and deploy the applications
- [x] The application can be deployed on Fly.io
- [x] The application runtime can be monitored using Prometheus/Grafana
- [ ] The application usage can be monitored using Plausible.io

## Ressources

### Geodata

- [Playing with GPX tracks in Elixir and PostGIS](https://caspg.com/blog/playing-with-gpx-tracks-in-elixir-and-postgis)
- [How to draw routes on a Maplibre GL (Mapbox GL) map](https://www.geoapify.com/tutorial/draw-route-on-the-maplibre-mapbox-map)

### Front-end

- [Create a to-do list app with Phoenix, React, and TypeScript](https://blog.logrocket.com/to-do-list-phoenix-react-typescript/)
- [Modern Webapps with React, Phoenix, Elixir and TypeScript](https://bpaulino.com/entries/modern-webapps-with-elixir-phoenix-typescript-react)

### Search

- [The Complete Guide to Full-text Search with Postgres and Ecto](https://www.peterullrich.com/complete-guide-to-full-text-search-with-postgres-and-ecto)