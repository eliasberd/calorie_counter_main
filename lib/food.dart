import 'package:flutter/material.dart';

class AddFood extends StatefulWidget {
  final String meal;
  const AddFood({super.key, required this.meal});


  @override
  State<AddFood> createState() => _AddFood();
}

class _AddFood extends State<AddFood> {
  int counter = 0;
  int selectedMealIndex = 0;
  int selectedCategoryIndex = 0;
  List<String> mealOptions = ['BREAKFAST', 'LUNCH', 'DINNER'];
  List<String> categoryOptions = ['FOOD', 'SAVED MEALS', 'RECENTLY EATEN'];
  List<bool> checkboxValues = List.generate(9, (index) => false);

  List<String> foodItems = [
    'Egg',
    'Chicken',
    'Lechon',
    'Rice',
    'Milk',
    'Century Tuna',
    'Whey Protein',
    'Food 8',
    'Food 9',
  ];

  List<String> gramsValues = [
    '50 grams',
    '120 grams',
    '200 grams',
    '150 grams',
    '80 grams',
    '75 grams',
    '90 grams',
    '110 grams',
    '70 grams',
  ];

  List<String> descriptionValues = [
    '70 kcal | 3% RDI',
    '220 kcal | 10% RDI',
    '380 kcal | 17% RDI',
    '210 kcal | 9% RDI',
    '90 kcal | 4% RDI',
    '120 kcal | 5% RDI',
    '360 kcal | 16% RDI',
    '160 kcal | 7% RDI',
    '180 kcal | 8% RDI',
  ];

  int calorieIntake = 3200;

  TextEditingController searchController = TextEditingController();
  List<String> filteredFoodItems = [];

  void updateSelectedMeal(int index) {
    setState(() {
      selectedMealIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    filteredFoodItems = List<String>.from(foodItems);
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void updateCounter(bool value, int calories) {
    setState(() {
      if (value) {
        counter++;
        calorieIntake -= calories;
      } else {
        counter--;
        calorieIntake += calories;
      }
    });
  }

  void searchFoodItems(String query) {
    setState(() {
      filteredFoodItems = foodItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double caloriePercentage = (calorieIntake / 3200); // Calculate the percentage of calorie intake

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          "Select Meal",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFF93E3E),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.check, color: Colors.white),
                onPressed: () {},
              ),
              if (counter > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Text(
                      counter.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: ToggleButtons(
                  isSelected: List.generate(3, (index) => index == selectedCategoryIndex),
                  children: categoryOptions
                      .map((value) => Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ))
                      .toList(),
                  onPressed: (int newIndex) {
                    setState(() {
                      selectedCategoryIndex = newIndex;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) => searchFoodItems(value),
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.black),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            if (selectedCategoryIndex == 0)
              Center(
                child: Text(
                  'FOOD CONTENT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            if (selectedCategoryIndex == 1)
              Center(
                child: Text(
                  'SAVED MEALS CONTENT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            if (selectedCategoryIndex == 2)
              Center(
                child: Text(
                  'RECENTLY EATEN CONTENT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            Center(
              child: Text(
                'Calorie Intake: $calorieIntake',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            AnimatedProgressIndicator(caloriePercentage: caloriePercentage),
            SizedBox(height: 10),
            for (var item in filteredFoodItems)
              FoodItemCard(
                item: item,
                gramsValue: gramsValues[foodItems.indexOf(item)],
                descriptionValue: descriptionValues[foodItems.indexOf(item)],
                checkboxValue: checkboxValues[foodItems.indexOf(item)],
                onCheckboxChanged: (value) {
                  updateCounter(value, int.parse(descriptionValues[foodItems.indexOf(item)].split(' ')[0]));
                  setState(() {
                    checkboxValues[foodItems.indexOf(item)] = value;
                  });
                },
                onGramsValueChanged: (value) {
                  gramsValues[foodItems.indexOf(item)] = value;
                },
              ),
          ],
        ),
      ),
    );
  }
}

class AnimatedProgressIndicator extends StatelessWidget {
  final double caloriePercentage;

  AnimatedProgressIndicator({required this.caloriePercentage});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1), // Change the duration as needed
      width: 350,
      height: 20,
      child: LinearProgressIndicator(
        backgroundColor: Colors.grey,
        value: caloriePercentage,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
      ),
    );
  }
}

class FoodItemCard extends StatefulWidget {
  final String item;
  final String gramsValue;
  final String descriptionValue;
  final bool checkboxValue;
  final ValueChanged<bool> onCheckboxChanged;
  final ValueChanged<String> onGramsValueChanged;

  FoodItemCard({
    required this.item,
    required this.gramsValue,
    required this.descriptionValue,
    required this.checkboxValue,
    required this.onCheckboxChanged,
    required this.onGramsValueChanged,
  });

  @override
  _FoodItemCardState createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: Color(0xFFDDDDDD),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                widget.item,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            if (isEditing)
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: widget.gramsValue),
                  onChanged: widget.onGramsValueChanged,
                  decoration: InputDecoration(
                    hintText: '100 grams',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Color(0xFFF93E3E),
                    fontSize: 14,
                  ),
                ),
              )
            else
              Expanded(
                child: Text(
                  widget.gramsValue,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF93E3E),
                    fontSize: 14,
                  ),
                ),
              ),
            Expanded(
              child: Text(
                widget.descriptionValue,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            Checkbox(
              value: widget.checkboxValue,
              onChanged: (value) {
                widget.onCheckboxChanged(value!); // Adjusted the null safety
                if (isEditing) {
                  setState(() {
                    isEditing = false;
                  });
                }
              },
            ),
            IconButton(
              icon: Icon(
                isEditing ? Icons.done : Icons.edit,
                color: Color(0xFFF93E3E),
              ),
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}