class Continent {
  final String name;
  const Continent._({required this.name}); // Private constructor

  // Define the Continents
  static const asia = Asia._();
  static const europe = Europe._();
  static const southAmerica = SouthAmerica._();
}

// Asia Namespace
class Asia extends Continent {
  const Asia._() : super._(name: 'Asia');

  // Countries are now properties of Asia
  final indonesia = const Country._(countryName: 'Indonesia');
  final japan = const Country._(countryName: 'Japan');
}

// Europe Namespace
class Europe extends Continent {
  const Europe._() : super._(name: 'Europe');

  final france = const Country._(countryName: 'France');
  final italy = const Country._(countryName: 'Italy');
}

// South America Namespace
class SouthAmerica extends Continent {
  const SouthAmerica._() : super._(name: 'South America');

  final brazil = const Country._(countryName: 'Brazil');
}

// The Country model
class Country {
  final String countryName;
  //  final String flagImage;

  const Country._({
    required this.countryName,
    //   required this.flagImage,
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

// enum Continent {
//   asia(continentName: 'Asia', countries: [Country.bali]),
//   europe(continentName: 'Europe', countries: [Country.france]),
//   southAmerica(continentName: 'South America', countries: [Country.brazil]);
//
//   final List<Country> countries;
//   final String continentName;
//   const Continent({required this.continentName, required this.countries});
// }
//
// enum Country {
//   brazil('Brazil'),
//   bali('Bali'),
//   france('France');
//
//   final String countryName;
//   const Country(this.countryName);
// }
