# Roadbook

# Introduction

*Roadbook* is a tool to help route planner ([Komoot](https://www.komoot.com), [Strava](https://www.strava.com), ...) users to create elevation maps from a GPS track.

- When a cyclist sees the trace of a stage, he can see **climb profiles** such as [example #1](https://climbfinder.com/en/climbs/alpe-d-huez) or [example #2](https://www.cols-cyclisme.com/vanoise/france/col-de-la-loze-depuis-brides-les-bains-c3612.htm) that breaks down mountain pass kilometer per kilometer with the percentage elevation per kilometer.
- When a cyclist uses a route planner such as Komoot, he can have the UI representation of the full route with the total elevation and the full profile, but no climbs breakdown.

This application builds a full roadbook (all climbs profiles) for a given route.

## Notebooks

To help develop the application, you can use the notebooks accessible in the `notebooks/` folder. Any notebook can be run using the [local livebook](http://localhost:8080),

```bash
just start
```

## Run local server

To run the web application,

```bash
mix phx.server
```

## Todo

### Core

- [ ] Implement https://caspg.com/blog/playing-with-gpx-tracks-in-elixir-and-postgis
- [ ] GPX > POSTGIS > GeoJson converter
- [ ] Climb Profile graph generator
- [ ] Climb Research engine
- [x] Write Climb Unit test
- [ ] Create Elevation Map object
 
### Web

- [ ] GPX file dump
- [ ] Create an homepage infinite Map

### Providers

- [ ] Export GPX from Strava
- [x] Dump data from https://www.cols-cyclisme.com
- [ ] Extract climbs start and stop locations
- [ ] Extract data from OpenStreetMap

### Release

- [ ] Dialyzer
- [ ] Deploy on Fly.io
- [ ] Github actions
- [ ] Install Plausible.io