void main() {
  //Task 1.
  print("Task 1.");
  int num = 7;

  for (int i = 1; i <= 10; i++) {
    print("$num * $i = ${num * i}");
  }
  print("");
  
  //Task 2.
  print("Task 2.");
  int day = 6;
  int month = 9;
  int year = 2026;

  int daysInMonth;

  if (month == 2) {
    if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
      daysInMonth = 29;
    } else {
      daysInMonth = 28;
    }
  } else if (month == 4 || month == 6 || month == 9 || month == 11) {
    daysInMonth = 30;
  } else {
    daysInMonth = 31;
  }


  if (day < daysInMonth) {
    day++;
  } else {
    day = 1;

    if (month < 12) {
      month++;
    } else {
      month = 1;
      year++;
    }
  }

  print("$day.$month.$year");
  print("");
  
  //Task 3.
  print("Task 3.");
  String text = "flutter mobile development";

  int count = 0;

  for (int i = 0; i < text.length; i++) {
    if ("aeiou".contains(text[i].toLowerCase())) {
      count++;
    }
  }

  print(count);
  print("");
  
  //Task 4.
  print("Task 4.");
  List<int> numbers = [14, 88, 3, 42, 99, 12, 67];

  int max = numbers[0];
  int min = numbers[0];

  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] > max) {
      max = numbers[i];
    }

    if (numbers[i] < min) {
      min = numbers[i];
    }
  }

  print("max: $max");
  print("min: $min");
  print("");
  
  //Task 5.
  print("Task 5.");
  int number = 5;

  bool isPrime = true;

  if (number < 2) {
    isPrime = false;
  }

  for (int i = 2; i < number; i++) {
    if (number % i == 0) {
      isPrime = false;
      break;
    }
  }

  if (isPrime) {
    print("$number - prime number");
  } else {
    print("$number - not prime number");
  }
}
