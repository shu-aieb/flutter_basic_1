class Continent {
  final String name;
  final List<Country> countries;

  const Continent({
    required this.name,
    required this.countries,
  }); // Private constructor
}

class Country {
  final String countryName;
  final String flagImage;
  final List<City> cities;

  const Country({
    required this.countryName,
    required this.flagImage,
    required this.cities,
  });
}

class City {
  final String cityName;
  final List<Spot> spots;

  City({required this.cityName, required this.spots});
}

class Spot {
  final String spotName;
  final String spotImage;

  Spot({required this.spotName, required this.spotImage});
}
