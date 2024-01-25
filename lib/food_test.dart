import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddFoodTest extends StatefulWidget {
  final String meal;
  const AddFoodTest({super.key, required this.meal});

  @override
  State<AddFoodTest> createState() => _AddFoodTestState();
}

class _AddFoodTestState extends State<AddFoodTest> {
  final databaseReference = FirebaseDatabase.instance.ref();
  String currentUid = '';
  List<String> foodItems = [
    'Egg',
    'Chicken',
    'Lechon',
    'Rice',
    'Milk',
    'Century Tuna',
    'Whey Protein',
  ];
  List<int> gramsValues = [
    50,
    120,
    200,
    150,
    80,
    75,
    90,
  ];
  List<bool> isCheckedList = List.generate(7, (index) => false);

  List<String> filteredFoodItems = [];

  @override
  void initState() {
    super.initState();
    setUid();
    // Initialize filteredFoodItems with all foodItems initially
    filteredFoodItems = List.from(foodItems);
  }

  void setUid() {
    FirebaseAuthService firebaseAuthService = FirebaseAuthService();
    setState(() {
      currentUid = firebaseAuthService.getCurrentUserUid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: const Text(
            'Add Food',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 28
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // Add checked items to Firebase Realtime Database
              addCheckedItemsToFirebase();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search food...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  onChanged: (value) {
                    // Filter the food items based on the search value
                    setState(() {
                      filteredFoodItems = foodItems
                          .where((item) => item.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredFoodItems.length,
                  itemBuilder: (context, index) {
                    int valuesTxt = gramsValues[foodItems.indexOf(filteredFoodItems[index])];
                    return InkWell(
                      onTap: () {
                        // Handle item click here
                        // You can add custom logic or navigation
                      },
                      child: Card(
                        color: const Color(0xFFD3D3D3), // Set the color to #D3D3D3
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            filteredFoodItems[index],
                            style: const TextStyle(
                              color: Colors.black, // Set the color of the text
                              fontWeight: FontWeight.bold, // Set the text to bold
                            ),
                          ),
                          subtitle: Text(
                            '$valuesTxt',
                            style: const TextStyle(
                              color: Colors.black, // Set the color of the values text
                              fontWeight: FontWeight.bold, // Set the text to bold
                            ),
                          ),
                          trailing: Checkbox(
                            value: isCheckedList[foodItems.indexOf(filteredFoodItems[index])],
                            onChanged: (value) {
                              setState(() {
                                isCheckedList[foodItems.indexOf(filteredFoodItems[index])] = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: CustomPaint(
              painter: TrianglePainter(isReversed: true),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: CustomPaint(
              painter: TrianglePainter(),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addCheckedItemsToFirebase() {
    for (int i = 0; i < isCheckedList.length; i++) {
      if (isCheckedList[i]) {
        // Add the checked item to Firebase Realtime Database
        databaseReference.child('addedFood').child(currentUid).child(widget.meal).child('$i').set({
          'food': foodItems[i],
          'cal': gramsValues[i],
        });
      }
    }
  }
}

class TrianglePainter extends CustomPainter {
  final bool isReversed;

  TrianglePainter({this.isReversed = false});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFFF5959), Color(0xFFFF2E63)],
      ).createShader(Rect.fromPoints(const Offset(0, 0), Offset(size.width, 0)));

    final Path path = Path();
    if (isReversed) {
      path.moveTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(0, size.height / 2);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, size.height / 2);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

