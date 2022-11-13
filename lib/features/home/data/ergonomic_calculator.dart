abstract class ErgonomicHeightCalculator {
  static const Map<int, int> _heights = {
    150: 40,
    160: 43,
    170: 46,
    180: 48,
    190: 51,
    200: 54,
  };

  static int get minUserHeight => _heights.keys.first;

  static int get maxUserHeight => _heights.keys.last;

  static bool isInsideRange(int height) {
    return height >= minUserHeight && height <= maxUserHeight;
  }

  static int? calculate(int height) {
    if (!isInsideRange(height)) {
      return null;
    }

    return _heights.entries
        .firstWhere(
          (element) => element.key > height,
        )
        .value;
  }
}
