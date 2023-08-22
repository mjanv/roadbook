import os
from dataclasses import dataclass

import geopandas as gpd
import networkx as nx
import osmnx as ox


@dataclass
class OpenStreetMap:
    folder: str

    def __post_init__(self):
        ox.config(use_cache=True, cache_folder=os.path.join(self.folder, "cache"))

    @staticmethod
    def geocode_address(G, address):
        geocode = gpd.tools.geocode(
            address, provider="nominatim", user_agent="drive time demo"
        ).to_crs(4326)
        return ox.nearest_nodes(
            G, geocode.iloc[0].geometry.x, geocode.iloc[0].geometry.y
        )

    def find_route(self, G, start, stop):
        route = nx.shortest_path(
            G,
            self.geocode_address(G, start),
            self.geocode_address(G, stop),
            weight="length",
        )
        return route

    def generate(self, start, stop, filename):
        G = ox.graph_from_address(start, dist=20000, network_type="all")
        route = self.find_route(G, start, stop)
        distance = round(
            sum(ox.utils_graph.get_route_edge_attributes(G, route, "length"))
        )

        fig, ax = ox.plot_graph(
            G,
            bgcolor="#061529",
            node_size=0,
            edge_linewidth=0.5,
            show=False,
            close=False,
        )
        ox.geometries_from_address(start, {"building": True}).plot(
            ax=ax, color="w", alpha=0.3
        )
        ox.geometries_from_address(start, {"natural": "water"}).plot(
            ax=ax, color="#72b1b1", alpha=0.3
        )
        ox.plot_graph_route(G, route, ax=ax, show=False)

        fig_path = os.path.join(self.folder, filename)
        fig.savefig(fig_path, bbox_inches="tight")
        return (fig_path, distance)


osm = OpenStreetMap(folder="osm")
osm.generate("Grenoble, France", "Col de Porte, France", "ok")