import 'package:flutter/material.dart';

class SliverMasteryPage extends StatelessWidget {
  const SliverMasteryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // CustomScrollView is the specific ScrollView that allows "Slivers" (scrollable fragments)
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0, // How tall it is when fully open
            pinned:
                true, // TRUE = It stays visible at the top (doesn't scroll away)
            floating:
                false, // FALSE = It doesn't appear immediately when scrolling down
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Burger King's Court",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              // The image that shrinks/fades
              background: Image.network(
                "https://picsum.photos/id/292/800/600",
                fit: BoxFit.cover,
                color: Colors.black45, // Darken image so text reads better
                colorBlendMode: BlendMode.darken,
              ),
            ),
            actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "The best burgers in town since 1995. Fresh ingredients, grilled to perfection.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chip(label: Text("Fast Food")),
                      SizedBox(width: 10),
                      Chip(label: Text("Burgers")),
                      SizedBox(width: 10),
                      Chip(label: Text("Drinks")),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // -----------------------------------------------------------------
          // 3. STICKY HEADER (The "Pro" Feature)
          // -----------------------------------------------------------------
          // This section title will scroll until it hits the AppBar, then it sticks!
          // We use a custom 'Delegate' class defined at the bottom of this file.
          SliverPersistentHeader(
            pinned: true, // Make it stick
            delegate: _SectionHeaderDelegate(title: "Popular Items (Grid)"),
          ),

          // -----------------------------------------------------------------
          // 4. SLIVER PADDING & GRID
          // -----------------------------------------------------------------
          // You can't wrap a SliverGrid in normal 'Padding'. You must use SliverPadding.
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items wide
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://picsum.photos/id/${index + 400}/200",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      color: Colors.black54,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Combo #${index + 1}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                childCount: 4, // 4 Popular items
              ),
            ),
          ),

          // -----------------------------------------------------------------
          // 5. SECOND STICKY HEADER
          // -----------------------------------------------------------------
          SliverPersistentHeader(
            pinned: true,
            delegate: _SectionHeaderDelegate(title: "Full Menu (List)"),
          ),

          // -----------------------------------------------------------------
          // 6. SLIVER LIST
          // -----------------------------------------------------------------
          // Standard vertical list, but optimized for Slivers.
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://picsum.photos/id/${index + 500}/100",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text("Delicious Meal ${index + 1}"),
                  subtitle: Text("\$12.99 • Spicy • 450 Kcal"),
                  trailing: Icon(Icons.add_circle, color: Colors.orange),
                );
              },
              childCount: 15, // Long list
            ),
          ),

          // -----------------------------------------------------------------
          // 7. FILL REMAINING (Footer)
          // -----------------------------------------------------------------
          // This fills whatever space is left on the screen.
          // If the list is short, this pushes to the bottom.
          // If the list is long, this sits at the very end.
          SliverFillRemaining(
            hasScrollBody: false, // Don't scroll inside this
            child: Container(
              color: Colors.grey[200],
              height: 100,
              alignment: Alignment.center,
              child: Text(
                "End of Menu • Thank you for ordering!",
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// HELPER CLASS FOR STICKY HEADERS
// ---------------------------------------------------------------------------
// This requires a bit of boilerplate code, but it is necessary for
// SliverPersistentHeader. This controls the min/max height of the sticky bar.
class _SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  _SectionHeaderDelegate({required this.title});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors
          .white, // Background color is needed so content doesn't show through
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      // Adding a shadow that appears only when it's "stuck" at the top can be done here logic-wise
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60.0; // Height when fully visible

  @override
  double get minExtent => 60.0; // Height when stuck at top

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false; // No need to rebuild if nothing changes
  }
}
