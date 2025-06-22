import 'dart:math';
import 'dart:ui';

class GlobalHelper {
  static Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255, // full opacity
      random.nextInt(256), // red (0-255)
      random.nextInt(256), // green (0-255)
      random.nextInt(256), // blue (0-255)
    );
  }
}
