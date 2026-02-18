import 'continent_v2.dart';

List<Continent> places = [
  Continent(
    name: 'South America',
    countries: [
      Country(
        countryName: 'France',
        flagImage: 'assets/images/france-flag.png',
        cities: [
          City(
            cityName: 'Bali',
            spots: [
              Spot(
                spotName: 'Eiffel Tower',
                spotImage: 'assets/images/eiffel-tower.jpg',
              ),
              Spot(
                spotName: 'Louvre Museum',
                spotImage: 'assets/images/louvre-museum.jpg',
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
