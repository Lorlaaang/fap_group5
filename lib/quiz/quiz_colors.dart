import 'package:flutter/material.dart';

class QuizColorsPage extends StatelessWidget {
  const QuizColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'BABY CHIME',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'BikePark',
          ),
        ),
      ),
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
          // Foreground Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: QuizColors(), // Ensure QuizColors widget is implemented properly
            ),
          ),
        ],
      ),
    );
  }
}


class QuizColors extends StatefulWidget {
  const QuizColors({super.key});

  @override
  State<QuizColors> createState() => _QuizColorsState();
}

class _QuizColorsState extends State<QuizColors> {
  @override

  List<Icon> scoreKeeper = [
    Icon(Icons.check, color: Colors.deepPurple),
    Icon(Icons.close, color: Colors.red),
    Icon(Icons.check, color: Colors.deepPurple),
  ];

  String item = 'CAT';

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Text(
              'SELECT THE CORRECT IMAGE',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.deepPurple,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.volume_up_outlined,
                    size: 30,
                  ),
                  onPressed: () {

                  },
                ),
                SizedBox(width: 8.0),
                Text(
                  item,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 1,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
               return GestureDetector(
                  onTap: () {
                    setState(() {

                    });
                  },
                  child: Container(
                    child: cardContainer(''),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50,
                  icon: const Icon(
                      Icons.arrow_back
                  ),
                  onPressed: () {

                  },
                ),
                Row(
                  children: scoreKeeper,
                ),
                IconButton(
                  iconSize: 50,
                  icon: const Icon(
                      Icons.arrow_forward
                  ),
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 80.0),
        ],
      ),
    );
  }
}

Widget cardContainer(String imagePath) {
  return Container(
    margin: EdgeInsets.all(6.0), // Add padding inside the container
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20), // Rounded corners
      border: Border.all(
        color: Colors.blueAccent, // Light blue outline
        width: 3, // Thickness of the outline
      ),
    ),
    child: Center(
      child: Image.asset('assets/images/colors.png'),
    ),
  );
}
