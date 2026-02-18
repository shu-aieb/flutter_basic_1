class LocationModel {
  late final String _continentName;
  late final String _countryName;
  late final String _image;
  late final String _flag;
  late final int _days;
  late final double _price;
  late final double _rating;
  late final int _reviews;

  LocationModel({
    required String continentName,
    required String countryName,
    required String image,
    required String flag,
    required int days,
    required double price,
    required double rating,
    required int reviews,
  }) {
    _continentName = continentName;
    _countryName = countryName;
    _image = image;
    _flag = flag;
    _days = days;
    _price = price;
    _rating = rating;
    _reviews = reviews;
  }

  String get continentName => _continentName;
  String get countryName => _countryName;
  String get image => _image;
  String get flag => _flag;
  int get days => _days;
  double get price => _price;
  double get rating => _rating;
  int get reviews => _reviews;
}
