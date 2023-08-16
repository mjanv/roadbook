defmodule Roadbook.Climbs.Providers.ColsCyclismeTest do
  @moduledoc false

  use ExUnit.Case

  @moduletag :external

  alias Roadbook.Climbs.Providers.ColsCyclisme

  test "From cols-cyclismes, the list of regions can be extracted" do
    regions = ColsCyclisme.load_regions()

    assert length(regions) == 137

    assert Enum.take(regions, 5) == [
             {"103", "Alpes maritimes", "/alpes-maritimes/liste-r61.htm"},
             {"38", "Aravis", "/aravis/liste-r51.htm"},
             {"35", "Arves et Grandes Rousses", "/arves-et-grandes-rousses/liste-r74.htm"},
             {"20", "Autre massif", "/autre-massif/liste-r6.htm"},
             {"35", "Baronnies", "/baronnies/liste-r63.htm"}
           ]
  end

  test "From cols-cyclismes, the list of climbs in a region can be extracted" do
    region = {"103", "Alpes maritimes", "/alpes-maritimes/liste-r61.htm"}

    climbs = ColsCyclisme.load_region_climbs(region)

    assert length(climbs) == 108

    assert Enum.take(climbs, 5) == [
             {"Baisse d'Ugail", "D43 /D143 ", "1388 m", "Alpes maritimes", "France",
              "/alpes-maritimes/france/baisse-d-ugail-depuis-d43-d143-c2992.htm"},
             {"Bay", "Entrevaux", "1146 m", "Alpes maritimes", "France",
              "/alpes-maritimes/france/bay-depuis-entrevaux-c2805.htm"},
             {"Berghe Inférieur", "Fontan", "863 m", "Alpes maritimes", "France",
              "/alpes-maritimes/france/berghe-inferieur-depuis-fontan-c2991.htm"},
             {"Camari", "Lantosque", "823 m", "Alpes maritimes", "France",
              "/alpes-maritimes/france/camari-depuis-lantosque-c3004.htm"},
             {"Camp militaire de Canjuers", "Montferrat", "812 m", "Alpes maritimes", "France",
              "/alpes-maritimes/france/camp-militaire-de-canjuers-depuis-montferrat-c3101.htm"}
           ]
  end

  test "From cols-cyclismes, the details from a climb can be extracted" do
    climb =
      {"Col de l'ecre", "Pont du Loup", "1118 m", "Alpes maritimes", "France",
       "/alpes-maritimes/france/col-de-l-ecre-depuis-pont-du-loup-c1313.htm"}

    details = ColsCyclisme.load_climb_details(climb)

    assert details == [
             nom: "Col de l'ecre",
             altitude: "1118 m",
             depart: "Pont du Loup",
             longueur: "18.70 km",
             denivellation: "919 m",
             pourcentage_moyen: "4.91%",
             pourcentage_maximal: "8.0%",
             massif: "Alpes maritimes, France",
             region: "Alpes maritimes",
             country: "France",
             url: "/alpes-maritimes/france/col-de-l-ecre-depuis-pont-du-loup-c1313.htm"
           ]
  end
end
