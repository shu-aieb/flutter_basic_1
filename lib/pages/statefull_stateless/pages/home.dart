import 'package:flutter/material.dart';

import '../data/location_model.dart';
import '../data/locations.dart';
import '../services/support_widget.dart';
import 'detail_location_page.dart';

enum Continent { asia, europe, southAmerica }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Continent _selectedContinent;
  late LocationModel _selectedLocation;
  /*
  late String _countryName;
  late String _continentName;
  late String _locationImg;

   */

  late Pages _selectedPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSelectedLocationInfo(Continent.southAmerica);
    _selectedPage = Pages.home;
  }

  void setSelectedLocationInfo(Continent continent) {
    _selectedContinent = continent;
    switch (continent) {
      case Continent.asia:
        _selectedLocation = Data.locations[0];
        break;
      case Continent.europe:
        _selectedLocation = Data.locations[1];
        break;
      case Continent.southAmerica:
        _selectedLocation = Data.locations[2];
        break;
    }
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //
  //   precacheImage(const AssetImage('assets/images/bali.jpg'), context);
  //   precacheImage(const AssetImage('assets/images/france.jpg'), context);
  //   precacheImage(const AssetImage('assets/images/brazil.jpg'), context);
  // }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height * 1;
    double totalWidth = MediaQuery.of(context).size.width * 1;

    double imageWidth = totalWidth * 0.9;
    double imageHeight = totalHeight * 0.45;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello Nusrat',
                          style: AppWidget.headlineText(22.0),
                        ),
                        Text(
                          'Welcome to TripGuide',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/images/girl.jpg",
                      width: totalWidth * 0.15,
                      height: totalWidth * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: totalHeight * 0.025),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: totalHeight * 0.065,
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: TextField(
                          style: TextStyle(
                            color: Color.fromARGB(96, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search Location',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(96, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Image.asset(
                      'assets/images/filter.png',
                      height: totalHeight * 0.035,
                      width: totalHeight * 0.035,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              SizedBox(height: totalHeight * 0.01),

              Divider(),
              SizedBox(height: totalHeight * 0.01),
              Text('Select Your Next Trip', style: AppWidget.headlineText(20)),
              SizedBox(height: totalHeight * 0.015),

              Container(
                height: totalHeight * 0.05,
                width: totalWidth,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    AppWidget.countryClip(
                      'Asia',
                      isSelect: _selectedContinent == Continent.asia,
                      onTap: () => setState(() {
                        setSelectedLocationInfo(Continent.asia);
                      }),
                    ),
                    SizedBox(width: totalWidth * 0.03),
                    AppWidget.countryClip(
                      'Europe',
                      isSelect: _selectedContinent == Continent.europe,
                      onTap: () => setState(() {
                        setSelectedLocationInfo(Continent.europe);
                      }),
                    ),
                    SizedBox(width: totalWidth * 0.03),
                    AppWidget.countryClip(
                      'South America',
                      isSelect: _selectedContinent == Continent.southAmerica,
                      onTap: () => setState(() {
                        setSelectedLocationInfo(Continent.southAmerica);
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: totalHeight * 0.035),
              LocationView(
                imageHeight: imageHeight,
                imageWidth: imageWidth,
                totalHeight: totalHeight,
                countryName: _selectedLocation.countryName,
                continentName: _selectedLocation.continentName,
                imageSrc: _selectedLocation.image,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailLocationPage(
                        selectedLocation: _selectedLocation,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: totalHeight * 0.025),
              BottomNavBar(selectedPage: _selectedPage),
              SizedBox(height: totalHeight * 0.025),
            ],
          ),
        ),
      ),
    );
  }
}
