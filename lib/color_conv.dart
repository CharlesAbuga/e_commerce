import 'package:flutter/material.dart';

Color getColorFromString(String colorString) {
  switch (colorString.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'yellow':
      return Colors.yellow;
    case 'orange':
      return Colors.orange;
    case 'purple':
      return Colors.purple;
    case 'pink':
      return Colors.pink;
    case 'brown':
      return Colors.brown;
    case 'grey':
      return Colors.grey;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    case 'cyan':
      return Colors.cyan;
    case 'teal':
      return Colors.teal;
    case 'silver':
      return const Color.fromARGB(255, 202, 198, 198);
    case 'gold':
      return const Color.fromARGB(255, 212, 175, 55);
    default:
      return Colors.black; // Default color if not recognized
  }
}
