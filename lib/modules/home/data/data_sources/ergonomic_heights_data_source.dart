import '../models/ergonomic_height_model.dart';

abstract class ErgonomicHeightsDataSource {
  static int get minUserHeight => heights.first.userHeightInCm;

  static int get maxUserHeight => heights.last.userHeightInCm;

  static int get _minChairHeight => heights.first.chairHeightInCm;

  static int get _maxChairHeight => heights.last.chairHeightInCm;

  static bool isChairHeightInsideRange(int chairHeight) {
    return chairHeight >= _minChairHeight && chairHeight <= _maxChairHeight;
  }

  static bool isUserHeightInsideRange(int userHeight) {
    return userHeight >= minUserHeight && userHeight <= maxUserHeight;
  }

  static ErgonomicHeightModel of(int userHeight) {
    if (!isUserHeightInsideRange(userHeight)) {
      throw 'Not in range, enter a height between '
          '${ErgonomicHeightsDataSource.minUserHeight} '
          'and ${ErgonomicHeightsDataSource.maxUserHeight}';
    }

    final height = heights.firstWhere(
      (element) => element.userHeightInCm > userHeight,
    );

    return height;
  }

  static const List<ErgonomicHeightModel> heights = [
    ErgonomicHeightModel(
      userHeightInCm: 165,
      chairHeightInCm: 0,
      monitorHeightInCm: 115,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 170,
      chairHeightInCm: 1,
      monitorHeightInCm: 118,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 175,
      chairHeightInCm: 3,
      monitorHeightInCm: 122,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 180,
      chairHeightInCm: 4,
      monitorHeightInCm: 125,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 185,
      chairHeightInCm: 6,
      monitorHeightInCm: 129,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 190,
      chairHeightInCm: 8,
      monitorHeightInCm: 132,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 195,
      chairHeightInCm: 9,
      monitorHeightInCm: 138,
    ),
  ];
}
