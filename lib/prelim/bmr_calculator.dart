class BMRCalculator {
  int calculateBMR({
    required int age,
    required double weight,
    required double height,
    required String sex,
    required String activityLevel,
  }) {
    int bmr = 0;

    // Constants for activity factors based on chosen activity level
    Map<String, double> activityFactors = {
      'Sedentary': 1.2,
      'Light Exercise': 1.375,
      'Moderate Exercise': 1.55,
      'Active Exercise': 1.725,
      'Very Active Exercise': 1.9,
      'Extra Active Exercise': 2.0,
    };

    // Calculate BMR based on sex
    if (sex.toLowerCase() == 'male') {
      bmr = (10 * weight + 6.25 * height - 5 * age + 5).round();
    } else if (sex.toLowerCase() == 'female') {
      bmr = (10 * weight + 6.25 * height - 5 * age - 161).round();
    } else {
      throw ArgumentError('Invalid value for sex. Use "male" or "female".');
    }

    // Apply activity factor
    if (activityFactors.containsKey(activityLevel)) {
      bmr = (bmr * activityFactors[activityLevel]!).round();
    } else {
      throw ArgumentError('Invalid value for activity level.');
    }

    return bmr;
  }
}

void main() {
  // Example usage
  BMRCalculator calculator = BMRCalculator();

  // User information
  int age = 25;
  double weight = 65.0;
  double height = 180.0;
  String sex = 'male';
  String activityLevel = 'Moderate Exercise';

  // Calculate BMR
  int calculatedBMR = calculator.calculateBMR(
    age: age,
    weight: weight,
    height: height,
    sex: sex,
    activityLevel: activityLevel,
  );

  // Display the calculated BMR
  print('Calculated BMR: $calculatedBMR calories/day');
}
