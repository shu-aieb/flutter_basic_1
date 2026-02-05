import 'package:flutter/material.dart';
import 'package:flutter_basics_1/pages/advanced_layout/custom_scroll/review.dart';

import 'activity.dart';

class CustomScrollShowcasePage extends StatefulWidget {
  const CustomScrollShowcasePage({super.key});

  @override
  State<CustomScrollShowcasePage> createState() =>
      _CustomScrollShowcasePageState();
}

class _CustomScrollShowcasePageState extends State<CustomScrollShowcasePage> {
  final List<Review> reviews = [
    Review(
      reviewerName: 'John Doe',
      reviewText:
          'This place was amazing! Highly recommend visiting during the sunset.',
      imageUrl: 'https://api.dicebear.com/9.x/adventurer/png?seed=George',
      rating: 5.0,
    ),
    Review(
      reviewerName: 'Ryker Rayen',
      reviewText: 'What an amazing experience. Looking forward to visit again.',
      imageUrl: 'https://api.dicebear.com/9.x/adventurer/png?seed=Ryker',
      rating: 4.75,
    ),
    Review(
      reviewerName: 'Brian Johnson',
      reviewText: 'Great place to relax. Enjoyed my stay.',
      imageUrl: 'https://api.dicebear.com/9.x/adventurer/png?seed=Brian',
      rating: 4.9,
    ),
    Review(
      reviewerName: 'Jude Jeny',
      reviewText: 'Great view, highly recommend.',
      imageUrl: 'https://api.dicebear.com/9.x/adventurer/png?seed=Maria',
      rating: 4.8,
    ),
    Review(
      reviewerName: 'Alexander Easton',
      reviewText:
          'Great place to explore. The rivers, the mountains and all give a very calm experience.',
      imageUrl: 'https://api.dicebear.com/9.x/adventurer/png?seed=Emery',
      rating: 5.0,
    ),
  ];

  final List<Activity> activities = [
    Activity(title: 'Surfing', icon: Icons.surfing, color: Colors.teal),
    Activity(title: 'Hiking', icon: Icons.hiking, color: Colors.green),

    Activity(title: 'Shopping', icon: Icons.shopping_bag, color: Colors.orange),
    Activity(
      title: 'Photography',
      icon: Icons.photo_camera,
      color: Colors.purple,
    ),
    Activity(title: 'Cycling', icon: Icons.motorcycle, color: Colors.red),
  ];

  final formula = 189;
  String imageUrl = "https://picsum.photos/id/15/800/600";
  String selectedImageUrl(int id) =>
      "https://picsum.photos/id/${id + formula}/800/600";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true, // Keeps the App Bar visible when scrolled up
            backgroundColor: Colors.deepPurple,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Visit Now",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              background: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                // Adding a dark filter so text is readable
                color: Colors.black.withValues(alpha: 0.3),
                colorBlendMode: BlendMode.darken,
              ),
            ),
            actions: [
              IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
            ],
          ),

          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => setState(() {
                    imageUrl = selectedImageUrl(index);
                  }),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 2.5,
                      right: 2.5,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black54, width: 1),
                      color: Colors.grey[300],
                      image: DecorationImage(
                        image: NetworkImage(selectedImageUrl(index)),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: Image.network(
                    //   "https://picsum.photos/id/${index + 50}/200",
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                );
              },
              childCount: 3, // Number of photos
            ),
          ),

          // 2. SLIVER TO BOX ADAPTER (Normal Widgets)
          // You use this when you want to put a normal Container/Column inside a CustomScrollView
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Island of the Gods",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Bali is a province of Indonesia and the westernmost of the Lesser Sunda Islands. It is a popular tourist destination known for its natural attractions, perfect climate and relaxed atmosphere.",
                    style: TextStyle(color: Colors.grey[700], height: 1.5),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Top Activities",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              height: 100,
              margin: EdgeInsets.only(bottom: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: activities.length,
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemBuilder: (context, index) {
                  return _topActivitiesCard(
                    activities[index].title,
                    activities[index].icon,
                    activities[index].color,
                  );
                },
              ),
            ),
          ),

          // 4. HEADER FOR GRID
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Text(
                "Photo Gallery (SliverGrid)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 5. SLIVER GRID (The Grid Part)
          // Notice we don't need shrinkWrap here! It's native to the scroll view.
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: Colors.grey[300],
                  child: Image.network(
                    "https://picsum.photos/id/${index + 50}/200",
                    fit: BoxFit.cover,
                  ),
                );
              },
              childCount: 6, // Number of photos
            ),
          ),

          // 6. HEADER FOR REVIEWS
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Recent Reviews (SliverList)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return _reviewCard(reviews[index]);
            }, childCount: reviews.length),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }

  Widget _reviewCard(Review review) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(review.imageUrl, fit: BoxFit.cover),
      ),
      title: Text(review.reviewerName),
      subtitle: Text(
        review.reviewText,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.amber, size: 16),
          Text(review.rating.toString()),
        ],
      ),
    );
  }

  Widget _topActivitiesCard(String title, IconData icon, Color color) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          SizedBox(height: 5),
          Text(title, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
