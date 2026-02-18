import 'package:flutter/material.dart';

import '../data/location_model.dart';
import '../data/locations.dart';
import '../services/support_widget.dart';

class DetailLocationPage extends StatefulWidget {
  const DetailLocationPage({super.key, required this.selectedLocation});

  final LocationModel selectedLocation;

  @override
  State<DetailLocationPage> createState() => _DetailLocationPageState();
}

class _DetailLocationPageState extends State<DetailLocationPage> {
  @override
  Widget build(BuildContext context) {
    double tWidth = MediaQuery.of(context).size.width;
    double tHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              widget.selectedLocation.image,
              width: tWidth,
              height: tHeight * 0.42,
              fit: BoxFit.cover,
            ),

            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: tHeight * 0.38),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.selectedLocation.continentName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),

                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star_border, size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.selectedLocation.rating.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                widget.selectedLocation.flag,
                                height: 30,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.selectedLocation.countryName,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${widget.selectedLocation.reviews} reviews',
                              style: TextStyle(
                                color: Color.fromARGB(123, 0, 0, 0),
                                fontFamily: 'Poppins',
                                fontSize: 13.5,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 10),
                        AppWidget.clickableText('Read More'),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Upcoming tours',
                              style: AppWidget.headlineText(22),
                            ),
                            Spacer(),
                            AppWidget.clickableText('See all'),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 255,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Data.locations.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: Colors.grey.shade200,
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        Data.locations[index].image,
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      Data.locations[index].continentName,
                                      style: AppWidget.headlineText(18),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppWidget.subText(
                                          'Days : ${Data.locations[index].days}',
                                        ),
                                        AppWidget.subText(
                                          'Per Person: ${Data.locations[index].price}',
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.star_outline, size: 20),
                                            SizedBox(width: 2),
                                            Text(
                                              Data.locations[index].rating
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                        AppWidget.subText(
                                          '(${Data.locations[index].reviews})',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.favorite_outline, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
