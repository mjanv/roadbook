# Roadbook

[**Live demo - Fly.io**](https://roadbook.fly.dev/)

*Roadbook* is a tool to help route planner ([Komoot](https://www.komoot.com), [Strava](https://www.strava.com), ...) users to create elevation maps from a GPS track.

- When a cyclist sees the trace of a stage, he can see **climb profiles** such as [example #1](https://climbfinder.com/en/climbs/alpe-d-huez) or [example #2](https://www.cols-cyclisme.com/vanoise/france/col-de-la-loze-depuis-brides-les-bains-c3612.htm) that breaks down mountain pass kilometer per kilometer with the percentage elevation per kilometer.
- When a cyclist uses a route planner such as Komoot, he can have the UI representation of the full route with the total elevation and the full profile, but no climbs breakdown.

This application builds a full roadbook (all climbs profiles) for a given route.

## Development

To develop, you need to have [just](https://github.com/casey/just), [docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/) installed.

### Notebooks

To help develop the application, you can use the notebooks accessible in the `notebooks/` folder. Any notebook can be run using the [local livebook](http://localhost:8080),

```bash
just start
```

### Run local server

To run the web application,

```bash
just start
just run
```

## Roadmap

### Core

- [ ] Write a GPX file / POSTGIS representation / GeoJson format converter
- [x] Write Climb unit tests
- [ ] Write a climb research engine to filter climbs by name, elevation, average slope or start/stop
- [ ] Create an elevation profile object
- [ ] Climb Profile graph generator

### Web

- [x] User accounts can be created from a registration page
- [x] Users can log in or out.
- [ ] The homepage is an infinite map displaying availables climbs
- [ ] An user can drag&drop an GPX file to the server
- [ ] When a user submits a GPX file,
  - [ ] the track is displayed onto a map
  - [ ] the track is analyzed to find all climbs profiles
  - [ ] all climbs profiles are displayed besides the map

### Providers

- [ ] GPX file dump from Strava planner is available
- [x] Climbs profile dataset from [Cols Cyclisme](https://www.cols-cyclisme.com) can be extracted
- [ ] From a given climb dataset, start and stop locations of each climb can be extracted
- [ ] Climb profile data from OpenStreetMap using the start and stop locations descriptions

### Release

- [x] Code quality is evaluated by Dialyzer
- [x] Github actions are used to test the quality, run the unit tests and deploy the applications
- [x] The application can be deployed on Fly.io
- [x] The application runtime can be monitored using Prometheus/Grafana
- [ ] The application usage can be monitored using Plausible.io

## Ressources

- [Playing with GPX tracks in Elixir and PostGIS](https://caspg.com/blog/playing-with-gpx-tracks-in-elixir-and-postgis)
- [How to draw routes on a Maplibre GL (Mapbox GL) map](https://www.geoapify.com/tutorial/draw-route-on-the-maplibre-mapbox-map)
- [Create a to-do list app with Phoenix, React, and TypeScript](https://blog.logrocket.com/to-do-list-phoenix-react-typescript/)
- [Modern Webapps with React, Phoenix, Elixir and TypeScript](https://bpaulino.com/entries/modern-webapps-with-elixir-phoenix-typescript-react)