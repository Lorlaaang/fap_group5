import 'package:flutter/material.dart';

class Category {
  final String name;
  final String description;
  final String image;
  final Color color;

  Category({
    required this.name,
    required this.description,
    required this.image,
    required this.color,
  });
}

class HomePage extends StatelessWidget {
  final List<Category> categories = [
    Category(
      name: 'Animals',
      description: 'Meet your favorite animals friends!',
      image: 'assets/images/animals.png',
      color: Colors.orange,
    ),
    Category(
      name: 'Shapes',
      description: 'Learn all about shapes!',
      image: 'assets/images/shapes.png',
      color: Colors.green,
    ),
    Category(
      name: 'Instruments',
      description: 'Explore musical instruments!',
      image: 'assets/images/instruments.png',
      color: Colors.pink,
    ),
    Category(
      name: 'Colors',
      description: 'Discover the world of colors!',
      image: 'assets/images/colors.png',
      color: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/homepage_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Column(
            children: [
              // AppBar
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Colors.green,
                child: Center(
                  child: Text(
                    'BABY CHIME',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'BikePark',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(category: category),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: category.color,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Category Info
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  category.description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            // Category Image
                            Image.asset(
                              category.image,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
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
        ],
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final Category category;

  const CategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: category.color,
      ),
      body: Center(
        child: Text(
          'Welcome to the ${category.name} category!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
