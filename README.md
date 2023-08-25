# Roadbook

![Banner](priv/static/images/banner.png)

<p align="center">
• [**Live demo**](https://roadbook.fly.dev/) • [**Roadmap**](https://github.com/users/mjanv/projects/3) • [**Github**](https://github.com/mjanv) •
</p>

*Roadbook* is a tool to help route planner ([Komoot](https://www.komoot.com), [Strava](https://www.strava.com), ...) users to create elevation maps from a GPS track.

- When a cyclist sees the trace of a stage, he can see **climb profiles** such as [example #1](https://climbfinder.com/en/climbs/alpe-d-huez) or [example #2](https://www.cols-cyclisme.com/vanoise/france/col-de-la-loze-depuis-brides-les-bains-c3612.htm) that breaks down mountain pass kilometer per kilometer with the percentage elevation per kilometer.
- When a cyclist uses a route planner such as Komoot, he can have the UI representation of the full route with the total elevation and the full profile, but no climbs breakdown.

This application builds a full roadbook (all climbs profiles) for a given route.

A [roadmap](https://github.com/users/mjanv/projects/3) of next developments is available on Github.

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

## Ressources

### Geodata

- [Playing with GPX tracks in Elixir and PostGIS](https://caspg.com/blog/playing-with-gpx-tracks-in-elixir-and-postgis)
- [How to draw routes on a Maplibre GL (Mapbox GL) map](https://www.geoapify.com/tutorial/draw-route-on-the-maplibre-mapbox-map)

### Front-end

- [Create a to-do list app with Phoenix, React, and TypeScript](https://blog.logrocket.com/to-do-list-phoenix-react-typescript/)
- [Modern Webapps with React, Phoenix, Elixir and TypeScript](https://bpaulino.com/entries/modern-webapps-with-elixir-phoenix-typescript-react)

### Search

- [The Complete Guide to Full-text Search with Postgres and Ecto](https://www.peterullrich.com/complete-guide-to-full-text-search-with-postgres-and-ecto)
