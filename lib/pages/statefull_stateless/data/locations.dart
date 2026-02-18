import 'continent.dart';
import 'location_model.dart';

class Data {
  static List<LocationModel> locations = [
    LocationModel(
      continentName: Continent.asia.name,
      countryName: Continent.asia.indonesia.countryName,
      image: 'assets/images/bali.jpg',
      flag: 'assets/images/indonesia-flag.png',
      days: 7,
      price: 300,
      rating: 4.2,
      reviews: 52,
    ),
    LocationModel(
      continentName: Continent.europe.name,
      countryName: Continent.europe.france.countryName,
      image: 'assets/images/france.jpg',
      flag: 'assets/images/france-flag.png',
      days: 8,
      price: 599,
      rating: 3.8,
      reviews: 83,
    ),
    LocationModel(
      continentName: Continent.southAmerica.name,
      countryName: Continent.southAmerica.brazil.countryName,
      image: 'assets/images/brazil.jpg',
      flag: 'assets/images/brazil-flag.png',
      days: 10,
      price: 499,
      rating: 4.5,
      reviews: 21,
    ),
  ];

  // static List<Map<String, String>> get locations => [
  //   {
  //     'name': ,
  //     'image': 'assets/images/bali.jpg',
  //     'days': '7 Days',
  //     'price': '\$300/person',
  //     'rating': '4.2',
  //     'reviews': '52 reviews',
  //   },
  //   {
  //     'name': 'Iconic France',
  //     'image': 'assets/images/france.jpg',
  //     'days': '8 Days',
  //     'price': '\$599/person',
  //     'rating': '3.8',
  //     'reviews': '83 reviews',
  //   },
  //   {
  //     'name': 'Iconic Brazil',
  //     'image': 'assets/images/brazil.jpg',
  //     'days': '10 Days',
  //     'price': '\$449/person',
  //     'rating': '4.5',
  //     'reviews': '21 reviews',
  //   },
  // ];
}
