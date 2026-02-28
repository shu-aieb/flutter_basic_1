import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'
    show timeDilation; // Critical for the slow-mo effect

// 1. SIMPLE MODEL
class Product {
  final String id;
  final String name;
  final String image; // URL
  final double price;
  final Color color;
  final String description;

  Product(
    this.id,
    this.name,
    this.image,
    this.price,
    this.color,
    this.description,
  );
}

class HeroAnimationPage extends StatefulWidget {
  @override
  _HeroAnimationPageState createState() => _HeroAnimationPageState();
}

class _HeroAnimationPageState extends State<HeroAnimationPage> {
  // Dummy Data
  final List<Product> products = [
    Product(
      "1",
      "Organic Avocado",
      "https://cdn.pixabay.com/photo/2020/05/29/18/16/avocado-5236857_1280.jpg",
      4.99,
      Colors.green,
      "Rich, creamy, and packed with healthy fats.",
    ),
    Product(
      "2",
      "Sweet Strawberry",
      "https://cdn.pixabay.com/photo/2021/09/23/05/30/strawberry-6648863_1280.jpg",
      3.50,
      Colors.redAccent,
      "Freshly picked, sweet and juicy red strawberries.",
    ),
    Product(
      "3",
      "Premium Banana",
      "https://cdn.pixabay.com/photo/2016/09/06/20/47/banana-1649969_1280.jpg",
      1.20,
      Colors.amber,
      "High energy snack rich in potassium.",
    ),
    Product(
      "4",
      "Fresh Orange",
      "https://cdn.pixabay.com/photo/2017/01/20/15/06/oranges-1995056_1280.jpg",
      2.10,
      Colors.orange,
      "Bursting with Vitamin C and citrus flavor.",
    ),
  ];

  bool _isSlowMotion = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("Hero Animation Market")),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Slow Motion Mode (Demo)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: _isSlowMotion,
                  activeColor: Colors.purple,
                  onChanged: (val) {
                    setState(() {
                      _isSlowMotion = val;
                      // 5.0 means 5x slower than normal
                      timeDilation = val ? 5.0 : 1.0;
                    });
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return GestureDetector(
                  onTap: () {
                    // Navigate to Detail Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: product.id,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: Image.network(
                                product.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "\$${product.price}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: product.color.withValues(alpha: 0.1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: product.id,
              child: Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(50),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(product.image),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    product.description * 3,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.black,
        icon: Icon(Icons.shopping_bag_outlined, color: Colors.white),
        label: Text("Add to Cart", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
