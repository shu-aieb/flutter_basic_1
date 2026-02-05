import 'package:flutter/material.dart';

class ListGridShowcasePage extends StatelessWidget {
  // Dummy Data for the examples
  final List<String> stories = [
    "My Story",
    "Alex",
    "Sarah",
    "John",
    "Mike",
    "Emily",
    "David",
  ];
  final List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.home, "title": "Home", "color": Colors.red},
    {"icon": Icons.wallet, "title": "Wallet", "color": Colors.blue},
    {
      "icon": Icons.settings,
      "title": "Settings",
      "color": Colors.amber.shade700,
    },
    {"icon": Icons.person, "title": "Profile", "color": Colors.green},
  ];

  ListGridShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lists & Grids Practice")),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "ListView (Horizontal)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        // Circle Avatar
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple[100],
                            border: Border.all(color: Colors.purple, width: 2),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://picsum.photos/id/${index + 50}/200',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: index == 0
                              ? Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withValues(alpha: 0.5),
                                  ),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(height: 5),
                        Text(stories[index], style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),

            Divider(thickness: 2),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "GridView",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            // GridView.count(
            //   crossAxisCount: 2,
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 10,
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   childAspectRatio: 2.5,
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //
            //   children: [
            //     _buildMenuCard(Icons.local_offer, "Offers", Colors.redAccent),
            //     _buildMenuCard(Icons.food_bank, "Food", Colors.orangeAccent),
            //     _buildMenuCard(Icons.movie, "Movies", Colors.blueAccent),
            //     _buildMenuCard(Icons.flight, "Travel", Colors.greenAccent),
            //   ],
            // ),
            //Divider(thickness: 2, height: 40),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: menuItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (context, index) {
                return _buildMenuCard(
                  menuItems[index]["icon"],
                  menuItems[index]['title'],
                  menuItems[index]['color'],
                );
              },
            ),

            Divider(thickness: 2, height: 40),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
              child: Text(
                "ListView",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                // Places a widget BETWEEN every item
                return Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  indent: 70,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text("Message Header $index"),
                  subtitle: Text("This is a subtitle text to show detail."),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    // Item click action
                    print("Tapped item $index");
                  },
                );
              },
            ),

            Divider(thickness: 2, height: 40),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "GridView - Gallery Style",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.7,
              ),
              itemCount: 9,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://picsum.photos/id/${index + 50}/300',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    color: Colors.black54,
                    child: Text(
                      "#$index",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
